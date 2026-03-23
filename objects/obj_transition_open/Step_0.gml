#region Opening

progress -= speed;

if (progress <= 0)
{
    progress = 0;
    instance_destroy();
}

#endregion