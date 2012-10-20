﻿/* Copyright (c) 2012 Rick (rick 'at' gibbed 'dot' us)
 * 
 * This software is provided 'as-is', without any express or implied
 * warranty. In no event will the authors be held liable for any damages
 * arising from the use of this software.
 * 
 * Permission is granted to anyone to use this software for any purpose,
 * including commercial applications, and to alter it and redistribute it
 * freely, subject to the following restrictions:
 * 
 * 1. The origin of this software must not be misrepresented; you must not
 *    claim that you wrote the original software. If you use this software
 *    in a product, an acknowledgment in the product documentation would
 *    be appreciated but is not required.
 * 
 * 2. Altered source versions must be plainly marked as such, and must not
 *    be misrepresented as being the original software.
 * 
 * 3. This notice may not be removed or altered from any source
 *    distribution.
 */

using System;
using System.Collections.Generic;
using System.ComponentModel.Composition;
using System.IO;
using System.Windows;
using Caliburn.Micro;
using Caliburn.Micro.Contrib;
using Caliburn.Micro.Contrib.Results;
using WillowTwoSave = Gibbed.Borderlands2.ProtoBufFormats.WillowTwoSave;
using Gibbed.IO;
using xPackage3;
using X360;
using X360.IO;
using X360.Other;
using X360.Profile;
using X360.STFS;
using System.Linq;


namespace Gibbed.Borderlands2.SaveEdit
{
    [Export(typeof(ShellViewModel))]
    internal class ShellViewModel : PropertyChangedBase
    {
        #region Fields
        private readonly IEventAggregator _Events;
        private readonly string _SavePath;
        private FileFormats.SaveFile _SaveFile;
        private GeneralViewModel _General;
        private CurrencyOnHandViewModel _CurrencyOnHand;
        private BackpackViewModel _Backpack;
        private BankViewModel _Bank;
        #endregion

        #region Properties
        public FileFormats.SaveFile SaveFile
        {
            get { return this._SaveFile; }
            private set
            {
                if (this._SaveFile != value)
                {
                    this._SaveFile = value;
                    this.NotifyOfPropertyChange(() => this.SaveFile);
                }
            }
        }

        [Import(typeof(GeneralViewModel))]
        public GeneralViewModel General
        {
            get { return this._General; }

            set
            {
                this._General = value;
                this.NotifyOfPropertyChange(() => this.General);
            }
        }

        [Import(typeof(CurrencyOnHandViewModel))]
        public CurrencyOnHandViewModel CurrencyOnHand
        {
            get { return this._CurrencyOnHand; }

            set
            {
                this._CurrencyOnHand = value;
                this.NotifyOfPropertyChange(() => this.CurrencyOnHand);
            }
        }

        [Import(typeof(BackpackViewModel))]
        public BackpackViewModel Backpack
        {
            get { return this._Backpack; }

            set
            {
                this._Backpack = value;
                this.NotifyOfPropertyChange(() => this.Backpack);
            }
        }

        [Import(typeof(BankViewModel))]
        public BankViewModel Bank
        {
            get { return this._Bank; }

            set
            {
                this._Bank = value;
                this.NotifyOfPropertyChange(() => this.Bank);
            }
        }
        #endregion

        [ImportingConstructor]
        public ShellViewModel(IEventAggregator events)
        {
            var savePath = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);
            if (string.IsNullOrEmpty(savePath) == false)
            {
                savePath = Path.Combine(savePath, "My Games");
                savePath = Path.Combine(savePath, "Borderlands 2", "WillowGame", "SaveData");

                if (Directory.Exists(savePath) == true)
                {
                    this._SavePath = savePath;
                }
            }

            this._Events = events;
            events.Subscribe(this);
        }

        public IEnumerable<IResult> ReadSave()
        {
            string fileName = null;

            MyOpenFileResult ofr;

            ofr = new MyOpenFileResult()
                .FilterFiles(
                    ffc => ffc.AddFilter("sav", true)
                               .WithDescription("Borderlands 2 Save Files"))
                .WithFileDo(s => fileName = s);

            if (string.IsNullOrEmpty(this._SavePath) == false &&
                Directory.Exists(this._SavePath) == true)
            {
                ofr = ofr.In(this._SavePath);
            }

            yield return ofr;
            if (fileName == null)
            {
                yield break;
            }
            string path = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
            //using (FileStream fs = File.Create(path)) { }
            Stream input1 = new FileStream(fileName, FileMode.Open);

            // Ensure that the target does not exist.
            File.Delete(path + "/savegame.sav");


            //Stream input = new Stream(fs);
            var check = input1.ReadValueU32(Endian.Big);

            input1.Close();
            if (check == 0x434F4E20)
            {
                //MessageBox.Show("This is a xbox save");

                STFSPackage xPackage = new STFSPackage(fileName, null);

                FileEntry xent = (FileEntry)xPackage.GetFile("savegame.sav");

                if (!xent.Extract(path + "/savegame.sav"))
                {
                    //MessageBoxEx.Show("Extraction Failed!", "Failed!", MessageBoxButtons.OK, MessageBoxIcon.[Error])
                    //xboxextract.ReportProgress(200, "Extraction Failed");
                    //Thread.Sleep(2000);
                    //Return
                    MessageBox.Show("Could not extract savegame.sav. Please use a program like modio or horizon to extract your savegame.sav");
                }
                else
                {
                    fileName = path + "/savegame.sav";
                    //MessageBox.Show("File extracted");
                    //Thread.Sleep(2000);
                    //MessageBoxEx.Show("Extraction Complete!", "Complete!", MessageBoxButtons.OK, MessageBoxIcon.Information)
                }

            }
            else
            {
                //MessageBox.Show("This is a pc save");
            }
            yield return new DelegateResult(() =>
            {
                FileFormats.SaveFile saveFile;
                using (var input = File.OpenRead(fileName))
                {
                    saveFile = FileFormats.SaveFile.Deserialize(input, FileFormats.SaveFile.DeserializeSettings.None);
                }

                this.SaveFile = saveFile;
                this.General.ImportData(saveFile.SaveGame, saveFile.Endian);
                this.CurrencyOnHand.ImportData(saveFile.SaveGame);
                this.Backpack.ImportData(saveFile.SaveGame);
                this.Bank.ImportData(saveFile.SaveGame);
            })
                .Rescue<DllNotFoundException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue<FileFormats.SaveFormatException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue<FileFormats.SaveCorruptionException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue().Execute(
                    x =>
                    new MyMessageBox("An exception was thrown (press Ctrl+C to copy):\n\n" + x.ToString(),
                                     "Error")
                        .WithIcon(MessageBoxImage.Error).AsCoroutine());
        }

        public IEnumerable<IResult> WriteSave()
        {
            if (this.SaveFile == null)
            {
                yield break;
            }

            string fileName = null;

            MySaveFileResult ofr;

            ofr = new MySaveFileResult()
                .PromptForOverwrite()
                .FilterFiles(
                    ffc => ffc.AddFilter("sav", true)
                               .WithDescription("Borderlands 2 Save Files")
                               .AddAllFilesFilter())
                .WithFileDo(s => fileName = s);

            if (string.IsNullOrEmpty(this._SavePath) == false &&
                Directory.Exists(this._SavePath) == true)
            {
                ofr = ofr.In(this._SavePath);
            }

            yield return ofr;

            if (fileName == null)
            {
                yield break;
            }

            var saveFile = this.SaveFile;

            yield return new DelegateResult(() =>
            {
                Endian endian;
                this.General.ExportData(saveFile.SaveGame, out endian);
                this.CurrencyOnHand.ExportData(saveFile.SaveGame);
                this.Backpack.ExportData(saveFile.SaveGame);
                this.Bank.ExportData(saveFile.SaveGame);

                using (var output = File.Create(fileName))
                {
                    saveFile.Endian = endian;
                    saveFile.Serialize(output);
                }
            }).Rescue().Execute(
                x =>
                new MyMessageBox("An exception was thrown (press Ctrl+C to copy):\n\n" + x.ToString(), "Error")
                    .WithIcon(MessageBoxImage.Error).AsCoroutine());
        }
        public IEnumerable<IResult> WriteSaveXbox()
        {
            if (this.SaveFile == null)
            {
                yield break;
            }
            string path = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
            File.Delete(path + "/savegame.sav");

            MessageBox.Show("A save file box will now appear, please select a EXISTING XBOX SAVE to overwrite. I can not emphasize this enough, ALWAYS KEEP A WORKING BACKUP. Once you have a backup press ok to continue");

            var saveFile = this.SaveFile;

            yield return new DelegateResult(() =>
            {
                Endian endian;
                this.General.ExportData(saveFile.SaveGame, out endian);
                this.CurrencyOnHand.ExportData(saveFile.SaveGame);
                this.Backpack.ExportData(saveFile.SaveGame);
                this.Bank.ExportData(saveFile.SaveGame);

                using (var output = File.Create(path + "/savegame.sav"))
                {
                    saveFile.Endian = endian;
                    saveFile.Serialize(output);
                }
            }).Rescue().Execute(
    x =>
    new MyMessageBox("An exception was thrown (press Ctrl+C to copy this text):\n\n" + x.ToString(), "Error")
        .WithIcon(MessageBoxImage.Error).AsCoroutine());

            string fileName = null;

            MySaveFileResult ofr;

            ofr = new MySaveFileResult()
                .PromptForOverwrite()
                .FilterFiles(
                    ffc => ffc.AddFilter("sav", true)
                               .WithDescription("Borderlands 2 Save Files")
                               .AddAllFilesFilter())
                .WithFileDo(s => fileName = s);

            if (string.IsNullOrEmpty(this._SavePath) == false &&
                Directory.Exists(this._SavePath) == true)
            {
                ofr = ofr.In(this._SavePath);
            }

            yield return ofr;

            if (fileName == null)
            {
                yield break;
            }

            yield return new DelegateResult(() =>
            {

                STFSPackage xPackage = new STFSPackage(fileName, null);
                FileEntry xent = (FileEntry)xPackage.GetFile("savegame.sav");
                if (!xent.Replace(path + "\\savegame.sav"))
                {
                    //If Not xent.Extract(Application.StartupPath + "\" + "savegame.sav") Then
                    //MessageBoxEx.Show("Extraction Failed!", "Failed!", MessageBoxButtons.OK, MessageBoxIcon.[Error])
                    throw new Exception("Failed to insert save file to xbox save. Please use a program like modio or horizon to insert your save");

                }
                else
                {


                    //If Not  Then

                    //End If
                    //MessageBoxEx.Show("Extraction Complete!", "Complete!", MessageBoxButtons.OK, MessageBoxIcon.Information)
                }
                if (!File.Exists(path + "/kv.bin"))
                {
                    File.WriteAllBytes(path + "/kv.bin", Properties.Resources.KV);
                }


                xPackage.FlushPackage(new RSAParams(path + "/kv.bin"));
                xPackage.CloseIO();
                //var stfs as new STFSPackage
                /*
                this._Events.Publish(new SavePackMessage(this.SaveFile));
                using (var output = File.Create(fileName))
                {
                    this.SaveFile.Serialize(output);
                }*/
            }).Rescue().Execute(
                x =>
                new MyMessageBox("An exception was thrown (press Ctrl+C to copy this text):\n\n" + x.ToString(), "Error")
                    .WithIcon(MessageBoxImage.Error).AsCoroutine());
        }
        //the next 5 functions create a new pc save
        public IEnumerable<IResult> NewAssassin()
        {

            string fileName = null;

            string path = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);

            File.Delete(path + "/savegame.sav");

            
            if (!File.Exists(path + "/savegame.sav"))
            {
                File.WriteAllBytes(path + "/savegame.sav", Properties.Resources.Assassin);
            }
            fileName = path + "/savegame.sav";

            yield return new DelegateResult(() =>
            {
                FileFormats.SaveFile saveFile;
                using (var input = File.OpenRead(fileName))
                {
                    saveFile = FileFormats.SaveFile.Deserialize(input, FileFormats.SaveFile.DeserializeSettings.None);
                }

                this.SaveFile = saveFile;
                this.General.ImportData(saveFile.SaveGame, saveFile.Endian);
                this.CurrencyOnHand.ImportData(saveFile.SaveGame);
                this.Backpack.ImportData(saveFile.SaveGame);
                this.Bank.ImportData(saveFile.SaveGame);
            })
                .Rescue<DllNotFoundException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue<FileFormats.SaveFormatException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue<FileFormats.SaveCorruptionException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue().Execute(
                    x =>
                    new MyMessageBox("An exception was thrown (press Ctrl+C to copy):\n\n" + x.ToString(),
                                     "Error")
                        .WithIcon(MessageBoxImage.Error).AsCoroutine());
        }
        public IEnumerable<IResult> NewSiren()
        {

            string fileName = null;

            string path = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);

            File.Delete(path + "/savegame.sav");


            if (!File.Exists(path + "/savegame.sav"))
            {
                File.WriteAllBytes(path + "/savegame.sav", Properties.Resources.Siren);
            }
            fileName = path + "/savegame.sav";

            yield return new DelegateResult(() =>
            {
                FileFormats.SaveFile saveFile;
                using (var input = File.OpenRead(fileName))
                {
                    saveFile = FileFormats.SaveFile.Deserialize(input, FileFormats.SaveFile.DeserializeSettings.None);
                }

                this.SaveFile = saveFile;
                this.General.ImportData(saveFile.SaveGame, saveFile.Endian);
                this.CurrencyOnHand.ImportData(saveFile.SaveGame);
                this.Backpack.ImportData(saveFile.SaveGame);
                this.Bank.ImportData(saveFile.SaveGame);
            })
                .Rescue<DllNotFoundException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue<FileFormats.SaveFormatException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue<FileFormats.SaveCorruptionException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue().Execute(
                    x =>
                    new MyMessageBox("An exception was thrown (press Ctrl+C to copy):\n\n" + x.ToString(),
                                     "Error")
                        .WithIcon(MessageBoxImage.Error).AsCoroutine());
        }
        public IEnumerable<IResult> NewGunzerker()
        {

            string fileName = null;

            string path = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);

            File.Delete(path + "/savegame.sav");


            if (!File.Exists(path + "/savegame.sav"))
            {
                File.WriteAllBytes(path + "/savegame.sav", Properties.Resources.Gunzerker);
            }
            fileName = path + "/savegame.sav";

            yield return new DelegateResult(() =>
            {
                FileFormats.SaveFile saveFile;
                using (var input = File.OpenRead(fileName))
                {
                    saveFile = FileFormats.SaveFile.Deserialize(input, FileFormats.SaveFile.DeserializeSettings.None);
                }

                this.SaveFile = saveFile;
                this.General.ImportData(saveFile.SaveGame, saveFile.Endian);
                this.CurrencyOnHand.ImportData(saveFile.SaveGame);
                this.Backpack.ImportData(saveFile.SaveGame);
                this.Bank.ImportData(saveFile.SaveGame);
            })
                .Rescue<DllNotFoundException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue<FileFormats.SaveFormatException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue<FileFormats.SaveCorruptionException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue().Execute(
                    x =>
                    new MyMessageBox("An exception was thrown (press Ctrl+C to copy):\n\n" + x.ToString(),
                                     "Error")
                        .WithIcon(MessageBoxImage.Error).AsCoroutine());
        }
        public IEnumerable<IResult> NewCommando()
        {

            string fileName = null;

            string path = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);

            File.Delete(path + "/savegame.sav");


            if (!File.Exists(path + "/savegame.sav"))
            {
                File.WriteAllBytes(path + "/savegame.sav", Properties.Resources.Commando);
            }
            fileName = path + "/savegame.sav";

            yield return new DelegateResult(() =>
            {
                FileFormats.SaveFile saveFile;
                using (var input = File.OpenRead(fileName))
                {
                    saveFile = FileFormats.SaveFile.Deserialize(input, FileFormats.SaveFile.DeserializeSettings.None);
                }

                this.SaveFile = saveFile;
                this.General.ImportData(saveFile.SaveGame, saveFile.Endian);
                this.CurrencyOnHand.ImportData(saveFile.SaveGame);
                this.Backpack.ImportData(saveFile.SaveGame);
                this.Bank.ImportData(saveFile.SaveGame);
            })
                .Rescue<DllNotFoundException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue<FileFormats.SaveFormatException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue<FileFormats.SaveCorruptionException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue().Execute(
                    x =>
                    new MyMessageBox("An exception was thrown (press Ctrl+C to copy):\n\n" + x.ToString(),
                                     "Error")
                        .WithIcon(MessageBoxImage.Error).AsCoroutine());
        }
        public IEnumerable<IResult> NewMechro()
        {

            string fileName = null;

            string path = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);

            File.Delete(path + "/savegame.sav");


            if (!File.Exists(path + "/savegame.sav"))
            {
                File.WriteAllBytes(path + "/savegame.sav", Properties.Resources.Mechromancer);
            }
            fileName = path + "/savegame.sav";

            yield return new DelegateResult(() =>
            {
                FileFormats.SaveFile saveFile;
                using (var input = File.OpenRead(fileName))
                {
                    saveFile = FileFormats.SaveFile.Deserialize(input, FileFormats.SaveFile.DeserializeSettings.None);
                }

                this.SaveFile = saveFile;
                this.General.ImportData(saveFile.SaveGame, saveFile.Endian);
                this.CurrencyOnHand.ImportData(saveFile.SaveGame);
                this.Backpack.ImportData(saveFile.SaveGame);
                this.Bank.ImportData(saveFile.SaveGame);
            })
                .Rescue<DllNotFoundException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue<FileFormats.SaveFormatException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue<FileFormats.SaveCorruptionException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue().Execute(
                    x =>
                    new MyMessageBox("An exception was thrown (press Ctrl+C to copy):\n\n" + x.ToString(),
                                     "Error")
                        .WithIcon(MessageBoxImage.Error).AsCoroutine());
        }
        //The nect 5 functions create a new xbox 360 save
        public IEnumerable<IResult> NewAssassin360()
        {

            string fileName = null;

            string path = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);

            File.Delete(path + "/savegame.sav");


            if (!File.Exists(path + "/savegame.sav"))
            {
                File.WriteAllBytes(path + "/savegame.sav", Properties.Resources.Assassin_360);
            }
            fileName = path + "/savegame.sav";

            yield return new DelegateResult(() =>
            {
                FileFormats.SaveFile saveFile;
                using (var input = File.OpenRead(fileName))
                {
                    saveFile = FileFormats.SaveFile.Deserialize(input, FileFormats.SaveFile.DeserializeSettings.None);
                }

                this.SaveFile = saveFile;
                this.General.ImportData(saveFile.SaveGame, saveFile.Endian);
                this.CurrencyOnHand.ImportData(saveFile.SaveGame);
                this.Backpack.ImportData(saveFile.SaveGame);
                this.Bank.ImportData(saveFile.SaveGame);
            })
                .Rescue<DllNotFoundException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue<FileFormats.SaveFormatException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue<FileFormats.SaveCorruptionException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue().Execute(
                    x =>
                    new MyMessageBox("An exception was thrown (press Ctrl+C to copy):\n\n" + x.ToString(),
                                     "Error")
                        .WithIcon(MessageBoxImage.Error).AsCoroutine());
        }
        public IEnumerable<IResult> NewSiren360()
        {

            string fileName = null;

            string path = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);

            File.Delete(path + "/savegame.sav");


            if (!File.Exists(path + "/savegame.sav"))
            {
                File.WriteAllBytes(path + "/savegame.sav", Properties.Resources.Siren_360);
            }
            fileName = path + "/savegame.sav";

            yield return new DelegateResult(() =>
            {
                FileFormats.SaveFile saveFile;
                using (var input = File.OpenRead(fileName))
                {
                    saveFile = FileFormats.SaveFile.Deserialize(input, FileFormats.SaveFile.DeserializeSettings.None);
                }

                this.SaveFile = saveFile;
                this.General.ImportData(saveFile.SaveGame, saveFile.Endian);
                this.CurrencyOnHand.ImportData(saveFile.SaveGame);
                this.Backpack.ImportData(saveFile.SaveGame);
                this.Bank.ImportData(saveFile.SaveGame);
            })
                .Rescue<DllNotFoundException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue<FileFormats.SaveFormatException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue<FileFormats.SaveCorruptionException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue().Execute(
                    x =>
                    new MyMessageBox("An exception was thrown (press Ctrl+C to copy):\n\n" + x.ToString(),
                                     "Error")
                        .WithIcon(MessageBoxImage.Error).AsCoroutine());
        }
        public IEnumerable<IResult> NewGunzerker360()
        {

            string fileName = null;

            string path = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);

            File.Delete(path + "/savegame.sav");


            if (!File.Exists(path + "/savegame.sav"))
            {
                File.WriteAllBytes(path + "/savegame.sav", Properties.Resources.Gunzerker_360);
            }
            fileName = path + "/savegame.sav";

            yield return new DelegateResult(() =>
            {
                FileFormats.SaveFile saveFile;
                using (var input = File.OpenRead(fileName))
                {
                    saveFile = FileFormats.SaveFile.Deserialize(input, FileFormats.SaveFile.DeserializeSettings.None);
                }

                this.SaveFile = saveFile;
                this.General.ImportData(saveFile.SaveGame, saveFile.Endian);
                this.CurrencyOnHand.ImportData(saveFile.SaveGame);
                this.Backpack.ImportData(saveFile.SaveGame);
                this.Bank.ImportData(saveFile.SaveGame);
            })
                .Rescue<DllNotFoundException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue<FileFormats.SaveFormatException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue<FileFormats.SaveCorruptionException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue().Execute(
                    x =>
                    new MyMessageBox("An exception was thrown (press Ctrl+C to copy):\n\n" + x.ToString(),
                                     "Error")
                        .WithIcon(MessageBoxImage.Error).AsCoroutine());
        }
        public IEnumerable<IResult> NewCommando360()
        {

            string fileName = null;

            string path = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);

            File.Delete(path + "/savegame.sav");


            if (!File.Exists(path + "/savegame.sav"))
            {
                File.WriteAllBytes(path + "/savegame.sav", Properties.Resources.Commando_360);
            }
            fileName = path + "/savegame.sav";

            yield return new DelegateResult(() =>
            {
                FileFormats.SaveFile saveFile;
                using (var input = File.OpenRead(fileName))
                {
                    saveFile = FileFormats.SaveFile.Deserialize(input, FileFormats.SaveFile.DeserializeSettings.None);
                }

                this.SaveFile = saveFile;
                this.General.ImportData(saveFile.SaveGame, saveFile.Endian);
                this.CurrencyOnHand.ImportData(saveFile.SaveGame);
                this.Backpack.ImportData(saveFile.SaveGame);
                this.Bank.ImportData(saveFile.SaveGame);
            })
                .Rescue<DllNotFoundException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue<FileFormats.SaveFormatException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue<FileFormats.SaveCorruptionException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue().Execute(
                    x =>
                    new MyMessageBox("An exception was thrown (press Ctrl+C to copy):\n\n" + x.ToString(),
                                     "Error")
                        .WithIcon(MessageBoxImage.Error).AsCoroutine());
        }
        public IEnumerable<IResult> NewMechro360()
        {

            string fileName = null;

            string path = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);

            File.Delete(path + "/savegame.sav");


            if (!File.Exists(path + "/savegame.sav"))
            {
                File.WriteAllBytes(path + "/savegame.sav", Properties.Resources.Mechromancer_360);
            }
            fileName = path + "/savegame.sav";

            yield return new DelegateResult(() =>
            {
                FileFormats.SaveFile saveFile;
                using (var input = File.OpenRead(fileName))
                {
                    saveFile = FileFormats.SaveFile.Deserialize(input, FileFormats.SaveFile.DeserializeSettings.None);
                }

                this.SaveFile = saveFile;
                this.General.ImportData(saveFile.SaveGame, saveFile.Endian);
                this.CurrencyOnHand.ImportData(saveFile.SaveGame);
                this.Backpack.ImportData(saveFile.SaveGame);
                this.Bank.ImportData(saveFile.SaveGame);
            })
                .Rescue<DllNotFoundException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue<FileFormats.SaveFormatException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue<FileFormats.SaveCorruptionException>().Execute(
                    x => new MyMessageBox("Failed to load save: " + x.Message, "Error")
                             .WithIcon(MessageBoxImage.Error).AsCoroutine())
                .Rescue().Execute(
                    x =>
                    new MyMessageBox("An exception was thrown (press Ctrl+C to copy):\n\n" + x.ToString(),
                                     "Error")
                        .WithIcon(MessageBoxImage.Error).AsCoroutine());
        }
    }
}
