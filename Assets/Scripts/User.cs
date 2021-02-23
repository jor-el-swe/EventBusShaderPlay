// Complete Source Code User:
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class DisableLightCommand : ICommand {
    readonly Light light;
    readonly Stack<bool> restoreStates = new Stack<bool>();

    public DisableLightCommand(Light light) {
        this.light = light;
    }

    public void Execute() {
        this.restoreStates.Push(this.light.enabled);
        this.light.enabled = false;
    }

    public void Undo() {
        this.light.enabled = this.restoreStates.Pop();
    }
}

public class ToggleLightCommand : ICommand {
    readonly Light light;

    public ToggleLightCommand(Light light) {
        this.light = light;
    }

    public void Execute() {
        this.light.enabled = !this.light.enabled;
    }

    public void Undo() {
        this.light.enabled = !this.light.enabled;
    }
}

public class CombinedCommand : ICommand {
    readonly ICommand[] commands;

    public CombinedCommand(params ICommand[] commands) {
        this.commands = commands;
    }

    public void Execute() {
        foreach (var command in this.commands) {
            command.Execute();
        }
    }

    public void Undo() {
        foreach (var command in this.commands.Reverse()) {
            command.Undo();
        }
    }
}

[CreateAssetMenu]
public class User : MonoBehaviour {
    public ProgrammableRemote remote;
    public Light redLight;
    public Light greenLight;
    public Light blueLight;
    void Start() {
        this.remote.Button1Function = new DisableLightCommand(this.redLight);
        this.remote.Button2Function = new ToggleLightCommand(this.blueLight);
        this.remote.Button3Function = new ToggleLightCommand(this.greenLight);
        this.remote.Button4Function = new CombinedCommand(
            new ToggleLightCommand(this.redLight), // true => false || true <= false
            new DisableLightCommand(this.redLight)               // false => false || false <= false
        );
    }
}