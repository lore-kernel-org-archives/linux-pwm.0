From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v2 0/2] pwm: sysfs: fix exporting PWM channel
Date: Fri, 12 Oct 2018 14:15:04 +0200
Message-ID: <ad0206b8-2cda-a147-1b71-8e2eced06e61@i2se.com>
References: <1538400237-28766-1-git-send-email-fabrice.gasnier@st.com>
 <20181012115500.GD31561@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181012115500.GD31561@ulmo>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: gottfried.haider@gmail.com, linux-pwm@vger.kernel.org, michal.vokac@ysoft.com, loic.pallardy@st.com, linux-kernel@vger.kernel.org, hsweeten@visionengravers.com, broonie@kernel.org, linux-rpi-kernel@lists.infradead.org, gohai@sukzessiv.net, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Am 12.10.2018 um 13:55 schrieb Thierry Reding:
> On Mon, Oct 01, 2018 at 03:23:55PM +0200, Fabrice Gasnier wrote:
>> Since commit 7e5d1fd75c3d ("pwm: Set class for exported channels in sysfs")
>> - it's not possible to export more than one PWM channel
>> - ABI has changed, as a side effect. It may cause bad behavior as pwmchip
>>   attributes are wrongly added to pwm channels and report wrong values.
>> See [1] and [2].
>>
>> One purpose of the original patch is to send uevents to udev, when exporting a
>> PWM channel through the sysfs. This series:
>> - Reverts the original patch.
>> - Proposes a new way to send notifications to be used by udev rules.
>>
>> - With this series:
>> $ echo 0 > /sys/class/pwm/pwmchip0/export
>> $ ls /sys/class/pwm
>> pwmchip0 pwmchip4
>>
>> $ ls /sys/class/pwm/pwmchip0/pwm0/
>> capture     enable      polarity    uevent
>> duty_cycle  period      power
>>
>> - Without this series:
>> $ echo 0 > /sys/class/pwm/pwmchip0/export
>> $ ls /sys/class/pwm
>> pwm0 pwmchip0 pwmchip4
>>
>> $ ls /sys/class/pwm/pwmchip0/pwm0/
>> capture     duty_cycle  export      period      power       uevent
>> device      enable      npwm        polarity    subsystem   unexport
>>
>> - Backtrace when exporting a 2nd channel (0) on a separate pwmchip device:
>> $ echo 0 > /sys/class/pwm/pwmchip4/export
>> [   95.286558] sysfs: cannot create duplicate filename '/class/pwm/pwm0'
>> [   95.293630] CPU: 0 PID: 54 Comm: sh Not tainted 4.19.0-rc6-00013-g00b49b0 #151
>> [   95.301344] Hardware name: STM32 (Device Tree Support)
>> [   95.306833] [<0000c155>] (unwind_backtrace) from [<0000b273>] (show_stack+0xb/0xc)
>> [   95.315136] [<0000b273>] (show_stack) from [<00092455>] (sysfs_warn_dup+0x31/0x48)
>> [   95.323247] [<00092455>] (sysfs_warn_dup) from [<00092635>] (sysfs_do_create_link_sd+0x75/0x88)
>> [   95.332539] [<00092635>] (sysfs_do_create_link_sd) from [<00125823>] (device_add+0x133/0x3b0)
>> [   95.341694] [<00125823>] (device_add) from [<001059ed>] (export_store+0xb5/0x12c)
>> [   95.349761] [<001059ed>] (export_store) from [<00091911>] (kernfs_fop_write+0x87/0xda)
>> [   95.358150] [<00091911>] (kernfs_fop_write) from [<0005beb1>] (__vfs_write+0x1d/0xe0)
>> [   95.366295] [<0005beb1>] (__vfs_write) from [<0005bfe7>] (vfs_write+0x4f/0x7c)
>> [   95.374053] [<0005bfe7>] (vfs_write) from [<0005c0bf>] (ksys_write+0x33/0x70)
>> [   95.381708] [<0005c0bf>] (ksys_write) from [<00009001>] (ret_fast_syscall+0x1/0x58)
>> [   95.389682] Exception stack(0x01bcffa8 to 0x01bcfff0)
>> [   95.394946] ffa0:                   00000000 00c4883c 00000001 00c4e590 00000002 00000004
>> [   95.403639] ffc0: 00000000 00c4883c 00c4cbe8 00000004 00000002 00000020 00000000 00c4d008
>> [   95.412223] ffe0: 00c29151 00c4cbe8 00c17833 00c13c0c
>> -sh: write error: File exists
>>
>> [1] https://lkml.org/lkml/2018/9/25/713
>> [2] https://lkml.org/lkml/2018/9/25/447
>>
>> ---
>> Changes in v2:
>> - update revert commit message
>> - new patch 2/2 to propose uevent notification (change) on pwmchip
>>
>> Fabrice Gasnier (2):
>>   Revert "pwm: Set class for exported channels in sysfs"
>>   pwm: send a uevent on the pwmchip device upon channel sysfs (un)export
>>
>>  drivers/pwm/sysfs.c | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
> Both patches applied, thanks. What do you think would be the importance
> of getting this into stable kernels? We can't get one of the patches in
> without the other, so they'd both have to be backported. The second one
> is still fairly small, so would qualify for stable, I think.
I think the revert patch should go to stable, because it fixes a regression.

Thanks
>
> However, given that it's taken a long time for somebody to notice this,
> I'm not sure if this is something that people care about too much in the
> stable kernels.
>
> Thierry
