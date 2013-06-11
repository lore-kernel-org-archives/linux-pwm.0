Return-Path: <hartleys@visionengravers.com>
Return-Path: <hartleys@visionengravers.com>
From: H Hartley Sweeten <hartleys@visionengravers.com>
Date: Tue, 11 Jun 2013 11:47:23 -0500
Subject: RE: [PATCH v4] pwm: add sysfs interface
Message-ID: <ADE657CA350FB648AAC2C43247A983F0021DA690F63A@AUSP01VMBX24.collaborationhost.net>
References: <201306101612.07708.hartleys@visionengravers.com>
 <20130611101432.GA932@manwe> <51B709F5.8070909@gmail.com>
 <ADE657CA350FB648AAC2C43247A983F0021DA690F61B@AUSP01VMBX24.collaborationhost.net>
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F0021DA690F61B@AUSP01VMBX24.collaborationhost.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-pwm.vger.kernel.org>
To: H Hartley Sweeten <hartleys@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "poeschel@lemonage.de" <poeschel@lemonage.de>, "rob@landley.net" <rob@landley.net>

On Tuesday, June 11, 2013 9:09 AM, H Hartley Sweeten wrote:
> On Tuesday, June 11, 2013 4:29 AM, Ryan Mallon wrote:
>> On 11/06/13 20:14, Thierry Reding wrote:
>>> On Mon, Jun 10, 2013 at 04:12:07PM -0700, H Hartley Sweeten wrote:
>>>> +config PWM_SYSFS
>>>> +	bool "/sys/class/pwm/... (sysfs interface)"
>>>> +	depends on SYSFS
>>>> +	help
>>>> +	  Say Y here to provide a sysfs interface to control PWMs.
>>>> +
>>>> +	  For every instance of a PWM device there is a pwmchipN directory
>>>> +	  created in /sys/class/pwm. Use the export attribute to request
>>>> +	  a PWM to be accessible from userspace and the unexport attribute
>>>> +	  to return the PWM to the kernel. Each exported PWM will have a
>>>> +	  pwmX directory in the pwmchipN it is associated with.
>>>=20
>>> I have a small quibble with this. Introducing options like this make it
>>> increasingly difficult to compile-test all the various combinations, so
>>> I'd like to see this converted to a form that will play well with the
>>> IS_ENABLED() macro. We already have the same issue with DEBUG_FS, only
>>> to a lesser degree because it doesn't have an additional PWM-specific
>>> Kconfig option.
>
> How about removing the Kconfig option and just doing:
>
> obj-$(CONFIG_SYSFS)			+=3D sysfs.o
>
> This way the PWM sysfs interface is always compiled and included in the b=
uild
> as long as CONFIG_SYSFS is enabled. The check in the header would change =
to

That didn't work. As Ryan pointed out we get undefined references due to
sysfs.c being compiled but not core.c when CONFIG_PWM is not enabled.

I'll change the PWM_SYSFS to a hidden option and repost the patch to see if
that is acceptable. Like Ryan mentioned, most test configs have CONFIG_SYSF=
S
enabled so as long as CONFIG_PWM is enabled we also get the sysfs interface=
.

Regards,
Hartley
