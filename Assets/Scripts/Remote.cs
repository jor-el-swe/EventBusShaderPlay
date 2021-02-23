// Complete Source Code Remote:
using System.Collections.Generic;
using UnityEngine;

public interface ICommand {
    void Execute();
    void Undo();
}

public class ProgrammableRemote : MonoBehaviour {

    public ICommand Button1Function;
    public ICommand Button2Function;
    public ICommand Button3Function;
    public ICommand Button4Function;

    readonly Stack<ICommand> commands = new Stack<ICommand>();
    
    [ContextMenu("Button1")]
    public void Button1() {
        this.Button1Function.Execute();
        this.commands.Push(this.Button1Function);
    }

    [ContextMenu("Button2")]
    public void Button2() {
        this.Button2Function.Execute();
        this.commands.Push(this.Button2Function);
    }

    [ContextMenu("Button3")]
    public void Button3() {
        this.Button3Function.Execute();
        this.commands.Push(this.Button3Function);
    }

    [ContextMenu("Button4")]
    public void Button4() {
        this.Button4Function.Execute();
        this.commands.Push(this.Button4Function);
    }

    [ContextMenu("Undo")]
    public void Undo() {
        this.commands.Pop().Undo();
    }
}