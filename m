From: Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
Subject: Re: [RESEND][PATCH] pwm: Set class for exported channels in sysfs
Date: Fri, 30 Mar 2018 14:40:11 +0200
Message-ID: <c1b6b62e-8fcb-bff0-b532-aa0879d301ed@st.com>
References: <20170926115951.GA29367@sukzessiv.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20170926115951.GA29367-SJMGYJWzoarE6SqAqhcbZQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: gohai-SJMGYJWzoarE6SqAqhcbZQ@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Gottfried Haider <gottfried.haider-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Loic PALLARDY <loic.pallardy-qxv4g6HH51o@public.gmane.org>, H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On 09/26/2017 01:59 PM, gohai-SJMGYJWzoarE6SqAqhcbZQ@public.gmane.org wrote:
> Notifications for devices without bus or class set get dropped by
> dev_uevent_filter. Adding the class to the exported child matches
> what the gpio subsystem is doing.
> 
> With this change exporting a channel triggers a udev event, which
> gives userspace a chance to fixup permissions and makes it possible
> for non-root users to make use of the pwm subsystem.
> 
> Signed-off-by: Gottfried Haider <gottfried.haider-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> CC: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> CC: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
> CC: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> CC: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> CC: linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> ---
>  drivers/pwm/sysfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
> index a813239..83f2b0b 100644
> --- a/drivers/pwm/sysfs.c
> +++ b/drivers/pwm/sysfs.c
> @@ -263,6 +263,7 @@ static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
>         export->pwm = pwm;
>         mutex_init(&export->lock);
> 
> +       export->child.class = parent->class;

Hi all,

Sorry to raise this old mail thread. I just figured out this patch is
causing *regression* on v4.16-rcs.

This patch has side effect at my end, with multiple pwm chip. It creates
a new entry in '/sys/class/pwm' every time a 'pwmX' is exported:
- echo X > export

This breaks pwm on platforms that have multiple pwmchip:
- 1st time export will create a /sys/class/pwm/pwmX
- when another export happens on another pwmchip, it can't be created
(e.g. -EEXIST)

I looked at /Documentation/ABI/testing/sysfs-class-pwm:
- pmwX should be there: /sys/class/pwm/pwmchipN/pwmX (only ?)

With this patch:
- pwmX symlink is created in addition, directly under /sys/class/pwm

Example on stm32 (stm32429i-eval) platform:
---
$ ls /sys/class/pwm
pwmchip0 pwmchip4

$ cd /sys/class/pwm/pwmchip0/
$ echo 0 > export

$ ls /sys/class/pwm
pwm0 pwmchip0 pwmchip4

$ cd /sys/class/pwm/pwmchip4/
$ echo 0 > export

sysfs: cannot create duplicate filename '/class/pwm/pwm0'
CPU: 0 PID: 50 Comm: sh Not tainted 4.16.0-rc7-00020-g3361545 #1682
Hardware name: STM32 (Device Tree Support)
[<0000c0f1>] (unwind_backtrace) from [<0000b23b>] (show_stack+0xb/0xc)
[<0000b23b>] (show_stack) from [<0008d2f1>] (sysfs_warn_dup+0x31/0x48)
[<0008d2f1>] (sysfs_warn_dup) from [<0008d4a5>]
(sysfs_do_create_link_sd+0x75/0x88)
[<0008d4a5>] (sysfs_do_create_link_sd) from [<000e8e91>]
(device_add+0x111/0x374)
[<000e8e91>] (device_add) from [<000ca795>] (export_store+0xb5/0x12c)
[<000ca795>] (export_store) from [<0008c899>] (kernfs_fop_write+0x87/0xda)
[<0008c899>] (kernfs_fop_write) from [<0005a0a5>] (__vfs_write+0x1d/0xcc)
[<0005a0a5>] (__vfs_write) from [<0005a1c7>] (vfs_write+0x4f/0x7c)
[<0005a1c7>] (vfs_write) from [<0005a29b>] (SyS_write+0x33/0x70)
[<0005a29b>] (SyS_write) from [<00009001>] (ret_fast_syscall+0x1/0x58)
Exception stack...
-sh: write error: File exists

Not sure what the best fix would be thought :-(

probably pwmX should be named also according with pwmchipN ?
- dev_set_name(&export->child, "pwm%u", pwm->hwpwm);
+ dev_set_name(&export->child, "pwmchip%d-pwm%u", chip->base, pwm->hwpwm);
BUT I think this would break existing ABI...

Also this is quite late in the cycle. Maybe a revert would be wise for now ?

Please advise,
Best Regards,
Fabrice

>         export->child.release = pwm_export_release;
>         export->child.parent = parent;
>         export->child.devt = MKDEV(0, 0);
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
