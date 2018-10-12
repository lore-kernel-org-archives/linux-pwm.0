From: =?iso-8859-2?Q?Vok=E1=E8_Michal?= <Michal.Vokac@ysoft.com>
Subject: Re: [PATCH v2 0/2] pwm: sysfs: fix exporting PWM channel
Date: Fri, 12 Oct 2018 12:44:21 +0000
Message-ID: <d58f077b-a486-31cb-d299-4ec556e91c08@ysoft.com>
References: <1538400237-28766-1-git-send-email-fabrice.gasnier@st.com>
 <20181012115500.GD31561@ulmo> <ad0206b8-2cda-a147-1b71-8e2eced06e61@i2se.com>
 <b56bc059-573f-545e-da45-51765f8937a7@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b56bc059-573f-545e-da45-51765f8937a7@st.com>
Content-Language: en-US
Content-ID: <6CF0D3102FD8AD4BA7F13CCCC8EB6F6F@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrice Gasnier <fabrice.gasnier@st.com>, Stefan Wahren <stefan.wahren@i2se.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: "gottfried.haider@gmail.com" <gottfried.haider@gmail.com>, "loic.pallardy@st.com" <loic.pallardy@st.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hsweeten@visionengravers.com" <hsweeten@visionengravers.com>, "broonie@kernel.org" <broonie@kernel.org>, "linux-rpi-kernel@lists.infradead.org" <linux-rpi-kernel@lists.infradead.org>, "gohai@sukzessiv.net" <gohai@sukzessiv.net>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

On 12.10.2018 14:36, Fabrice Gasnier wrote:
> On 10/12/2018 02:15 PM, Stefan Wahren wrote:
>> Am 12.10.2018 um 13:55 schrieb Thierry Reding:
>>> On Mon, Oct 01, 2018 at 03:23:55PM +0200, Fabrice Gasnier wrote:
>>>> Since commit 7e5d1fd75c3d ("pwm: Set class for exported channels in sy=
sfs")
>>>> - it's not possible to export more than one PWM channel
>>>> - ABI has changed, as a side effect. It may cause bad behavior as pwmc=
hip
>>>>    attributes are wrongly added to pwm channels and report wrong value=
s.
>>>> See [1] and [2].
>>>>
>>>> One purpose of the original patch is to send uevents to udev, when exp=
orting a
>>>> PWM channel through the sysfs. This series:
>>>> - Reverts the original patch.
>>>> - Proposes a new way to send notifications to be used by udev rules.
>>>>
>>>> - With this series:
>>>> $ echo 0 > /sys/class/pwm/pwmchip0/export
>>>> $ ls /sys/class/pwm
>>>> pwmchip0 pwmchip4
>>>>
>>>> $ ls /sys/class/pwm/pwmchip0/pwm0/
>>>> capture     enable      polarity    uevent
>>>> duty_cycle  period      power
>>>>
>>>> - Without this series:
>>>> $ echo 0 > /sys/class/pwm/pwmchip0/export
>>>> $ ls /sys/class/pwm
>>>> pwm0 pwmchip0 pwmchip4
>>>>
>>>> $ ls /sys/class/pwm/pwmchip0/pwm0/
>>>> capture     duty_cycle  export      period      power       uevent
>>>> device      enable      npwm        polarity    subsystem   unexport
>>>>
>>>> - Backtrace when exporting a 2nd channel (0) on a separate pwmchip dev=
ice:
>>>> $ echo 0 > /sys/class/pwm/pwmchip4/export
>>>> [   95.286558] sysfs: cannot create duplicate filename '/class/pwm/pwm=
0'
>>>> [   95.293630] CPU: 0 PID: 54 Comm: sh Not tainted 4.19.0-rc6-00013-g0=
0b49b0 #151
>>>> [   95.301344] Hardware name: STM32 (Device Tree Support)
>>>> [   95.306833] [<0000c155>] (unwind_backtrace) from [<0000b273>] (show=
_stack+0xb/0xc)
>>>> [   95.315136] [<0000b273>] (show_stack) from [<00092455>] (sysfs_warn=
_dup+0x31/0x48)
>>>> [   95.323247] [<00092455>] (sysfs_warn_dup) from [<00092635>] (sysfs_=
do_create_link_sd+0x75/0x88)
>>>> [   95.332539] [<00092635>] (sysfs_do_create_link_sd) from [<00125823>=
] (device_add+0x133/0x3b0)
>>>> [   95.341694] [<00125823>] (device_add) from [<001059ed>] (export_sto=
re+0xb5/0x12c)
>>>> [   95.349761] [<001059ed>] (export_store) from [<00091911>] (kernfs_f=
op_write+0x87/0xda)
>>>> [   95.358150] [<00091911>] (kernfs_fop_write) from [<0005beb1>] (__vf=
s_write+0x1d/0xe0)
>>>> [   95.366295] [<0005beb1>] (__vfs_write) from [<0005bfe7>] (vfs_write=
+0x4f/0x7c)
>>>> [   95.374053] [<0005bfe7>] (vfs_write) from [<0005c0bf>] (ksys_write+=
0x33/0x70)
>>>> [   95.381708] [<0005c0bf>] (ksys_write) from [<00009001>] (ret_fast_s=
yscall+0x1/0x58)
>>>> [   95.389682] Exception stack(0x01bcffa8 to 0x01bcfff0)
>>>> [   95.394946] ffa0:                   00000000 00c4883c 00000001 00c4=
e590 00000002 00000004
>>>> [   95.403639] ffc0: 00000000 00c4883c 00c4cbe8 00000004 00000002 0000=
0020 00000000 00c4d008
>>>> [   95.412223] ffe0: 00c29151 00c4cbe8 00c17833 00c13c0c
>>>> -sh: write error: File exists
>>>>
>>>> [1] https://lkml.org/lkml/2018/9/25/713
>>>> [2] https://lkml.org/lkml/2018/9/25/447
>>>>
>>>> ---
>>>> Changes in v2:
>>>> - update revert commit message
>>>> - new patch 2/2 to propose uevent notification (change) on pwmchip
>>>>
>>>> Fabrice Gasnier (2):
>>>>    Revert "pwm: Set class for exported channels in sysfs"
>>>>    pwm: send a uevent on the pwmchip device upon channel sysfs (un)exp=
ort
>>>>
>>>>   drivers/pwm/sysfs.c | 12 +++++++++++-
>>>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>> Both patches applied, thanks. What do you think would be the importance
>>> of getting this into stable kernels? We can't get one of the patches in
>>> without the other, so they'd both have to be backported. The second one
>>> is still fairly small, so would qualify for stable, I think.
>> I think the revert patch should go to stable, because it fixes a regress=
ion.
>>
>=20
> Hi,
>=20
> Thierry, Thanks for taking these.
> I also think at least the 1st patch (revert) should be backported in
> stable branch. Not taking the second one may lead to another issue for
> the users that now expect uevents. This is replacement patch to the
> original one. So, I'd advise to push both: revert + replacement patch.

I also vote for pushing both.
M.

>>> However, given that it's taken a long time for somebody to notice this,
>>> I'm not sure if this is something that people care about too much in th=
e
>>> stable kernels>>
>>> Thierry
