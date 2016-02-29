From: Pedro Aguilar <p.aguilar@nethix.com>
Subject: Re: LCD with PWM backlight doesn't seem to work with atmel-hlcdc
 driver
Date: Mon, 29 Feb 2016 15:25:01 +0100
Message-ID: <56D454BD.6020605@nethix.com>
References: <5693F69A.8010204@nethix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtpout11.impresasemplice.it ([83.221.127.135]:4014 "EHLO
	smtpout11.impresasemplice.it" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752810AbcB2Oas (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Feb 2016 09:30:48 -0500
In-Reply-To: <5693F69A.8010204@nethix.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org

Hi,

Just to clarify that we solved this issue a couple of days after the 
original email.

The problem was that we wanted to use for the LCD PWM (backlight) a 
DIV_1 that the driver does not allow because of an issue with the Atmel 
SAMA5D34 (the atmel-hlcdc driver handles it correctly, see section 
60.4.1 in the datasheet).

With the other DIV_2-64 everything is working fine.

Regards.
--
Pedro Aguilar

Nethix s.r.l
Via dei Pini, 21
31033 Castelfranco Veneto (TV)
T. +39 0423 770750 - F. +39 0423 770749
www.nethix.com

This e-mail, including attachments if any, is privileged and
confidential, and is intended for the named recipient(s)only. Any form
of disclosure, modification, distribution and/or publication of this
e-mail, including attachments is prohibited without prior permission and
could amount to a violation of civil and criminal laws and regulations.
If you have received this message by mistake, you are asked to inform
the sender and then to delete this message and any copies of it.
Although we have taken reasonable precautions to ensure no viruses are
present in this email, we disclaim any liability for any damage caused
by any virus transmitted by this email. Thank you for your cooperation.

On 01/11/2016 07:38 PM, Pedro Aguilar wrote:
> Hi,
>
> I'm working on a custom board based on the Atmel sama5d3_ek. I have an
> LCD (T430T01W01A from Cristal Clear Technology) that has a PWM backlight
> and it should be supported in the device tree files (sama5d34ek_pda4)
> and the panel_simple driver since it's compatible with the already
> supported Innolux at043tn24.
>
> When booting I see in the LCD the Atmel logo with some info, this means
> that electrically the board and the LCD work fine.
>
> I built the LCD modules (pwm_atmel_hlcdc, backlight, pwm_bl,
> panel_simple and atmel_hlcdc_dc) out of the kernel and modprobe'd them
> manually after booting:
>
> # modprobe pwm_atmel_hlcdc
> # modprobe backlight
> # modprobe pwm_bl
> backlight_device_register: name=backlight
> # modprobe panel_simple
> # modprobe atmel_hlcdc_dc
> [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [drm] No driver support for vblank timestamp query.
> atmel-hlcdc-display-controller atmel-hlcdc-dc: DRM device successfully
> registered
> atmel-hlcdc-display-controller atmel-hlcdc-dc: fb0: frame buffer device
> atmel-hlcdc-display-controller atmel-hlcdc-dc: registered panic notifier
> #
>
> When modprobing pwm_bl the LCD seemed to be turned-off (the logo from
> uboot goes away) and the the PWM backlight is off.
>
> I tried several user space programs (fb-set-rect and Qt5 examples built
> with buildroot) but the LCD seemed dead. All the entries in sysfs, such
> as /sys/class/backlight were present, but didn't work. For example, I
> tried to power on/off the backlight
>
> echo 1 > /sys/class/backlight/backlight/bl_power
> echo 0 > /sys/class/backlight/backlight/bl_power
>
> but it didn't work. The same with the brightness.
>
> The datasheet of this LCD and the Innolux LCD are equivalent.
>
> It seems that there is something related to the voltage in the PWM
> backlight or panel regulators?
>
> Do you have any idea/hint of what could cause this issue?
>
> Thanks!
>
> --
> Pedro Aguilar
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pwm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
