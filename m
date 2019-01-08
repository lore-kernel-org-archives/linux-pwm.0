From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: Handle pwm with sysfs with recent kernel
Date: Tue, 8 Jan 2019 23:21:02 +0100
Message-ID: <20190108222102.hwv5oekspifhj7bh@pengutronix.de>
References: <20190108100739.GA9046@arthur-bzh>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190108100739.GA9046@arthur-bzh>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arthur LAMBERT <lambertarthur22@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

[Cc: +=3D linux-pwm list]

Hello Arthur,

On Tue, Jan 08, 2019 at 11:07:39AM +0100, Arthur LAMBERT wrote:
> I am trying to update my kernel bsp from v4.1.X to v4.19.8 but I have som=
e regressions
> when I try to use pwm through sysfs from userspace. I have three pwm decl=
ared as
> follow in my device tree :
> =

> 	leds {
> 	     compatible =3D "pwm-leds";
> 	     ledred {
> 		pwms =3D <&pwm1>;
> 		label =3D "red";
> 		linux,default-trigger =3D "none";
> 		default-state =3D "on";
> 	     };
> =

> 	     ledblue {
> 	     	pwms =3D <&pwm5>;
> 		label =3D "blue";
> 		linux,default-trigger =3D "none";
> 		default-state =3D "on";
> 	     };
> =

> 	     ledgreen {
> 	     	pwms =3D <&pwm6>;
> 		label =3D "green";
> 		linux,default-trigger =3D "none";
> 		default-state =3D "on";
> 	     };
> 	};
> =

> First I have an issue with duplicate name :
> sysfs: cannot create duplicate filename '/class/pwm/pwm0'
> CPU: 0 PID: 653 Comm: XXXX
> Hardware name: Freescale i.MX6 Ultralite (Device Tree)
> [<8010dda8>] (unwind_backtrace) from [<8010b468>] (show_stack+0x10/0x14)
> [<8010b468>] (show_stack) from [<8025ef0c>] (sysfs_warn_dup+0x58/0x64)
> [<8025ef0c>] (sysfs_warn_dup) from [<8025f200>] (sysfs_do_create_link_sd+=
0xd4/0xd8)
> [<8025f200>] (sysfs_do_create_link_sd) from [<80458d6c>] (device_add+0x1e=
c/0x5d4)
> [<80458d6c>] (device_add) from [<8040b5a8>] (export_store+0xfc/0x17c)
> [<8040b5a8>] (export_store) from [<80456904>] (dev_attr_store+0x18/0x24)
> [<80456904>] (dev_attr_store) from [<8025e604>] (sysfs_kf_write+0x44/0x48)
> [<8025e604>] (sysfs_kf_write) from [<8025dcb0>] (kernfs_fop_write+0xe8/0x=
1d0)
> [<8025dcb0>] (kernfs_fop_write) from [<801eaaf8>] (__vfs_write+0x28/0x144)
> [<801eaaf8>] (__vfs_write) from [<801ead88>] (vfs_write+0xa4/0x164)
> [<801ead88>] (vfs_write) from [<801eaf54>] (ksys_write+0x40/0x94)
> [<801eaf54>] (ksys_write) from [<80101000>] (ret_fast_syscall+0x0
> =

> I was able to fix it by revert a patch : https://patchwork.kernel.org/pat=
ch/9971821/
> It is normal that this revert patch is not currently apply on last 4.19.X=
 tag (last one
> seems to be 4.19.13)
> =

> Then I have another issue when I try to enable my pwm :
> =

> # ls /sys/class/pwm/
> pwmchip0  pwmchip2  pwmchip4  pwmchip6
> pwmchip1  pwmchip3  pwmchip5  pwmchip7
> # echo 0 > /sys/class/pwm/pwmchip0/export
> # echo 1 > /sys/class/pwm/pwmchip0/pwm0/enable
> -sh: write error: Invalid argument

Just a guess: did you check that /sys/class/pwm/pwmchip0/pwm0/enable
actually exists?

> Is there a new way to handle pwm in recent kernel ? My old process is
> now deprecated or something ?

Not sure what you want to achive and if pwmchip0/pwm0 is one of the pwms
used in your dts snipped above. If the pwm is in use, don't expect it to
be controllable via sysfs.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
