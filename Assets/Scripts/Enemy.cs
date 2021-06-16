using EventBrokerFolder;
using UnityEngine;

public class Enemy : MonoBehaviour
{
    void OnTriggerEnter(Collider other) {
        EventBroker.Instance().SendMessage(new PlayerHealthMessage(666));
    }
}
