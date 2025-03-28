using System;
using UnityEngine;

namespace MyCore.SceneFader
{
    public abstract class BaseSceneFaderAnimation : MonoBehaviour, ISceneFaderAnimation
    {
        public abstract void Hide(Action callback);

        public abstract void HideImmediately();

        public abstract void Show(Action callback);

        public abstract void ShowImmediately();
    }
}
