Return-Path: <hartleys@visionengravers.com>
Return-Path: <hartleys@visionengravers.com>
From: H Hartley Sweeten <hartleys@visionengravers.com>
Date: Tue, 11 Jun 2013 11:09:24 -0500
Subject: RE: [PATCH v4] pwm: add sysfs interface
Message-ID: <ADE657CA350FB648AAC2C43247A983F0021DA690F61B@AUSP01VMBX24.collaborationhost.net>
References: <201306101612.07708.hartleys@visionengravers.com>
 <20130611101432.GA932@manwe> <51B709F5.8070909@gmail.com>
In-Reply-To: <51B709F5.8070909@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-pwm.vger.kernel.org>
To: Ryan Mallon <rmallon@gmail.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "poeschel@lemonage.de" <poeschel@lemonage.de>, "rob@landley.net" <rob@landley.net>

On Tuesday, June 11, 2013 4:29 AM, Ryan Mallon wrote:
> On 11/06/13 20:14, Thierry Reding wrote:
>> On Mon, Jun 10, 2013 at 04:12:07PM -0700, H Hartley Sweeten wrote:
>> [...]
>>> +What:		/sys/class/pwm/pwmchipN/pwmX/duty
>>> +Date:		May 2013
>>> +KernelVersion:	3.11
>>> +Contact:	H Hartley Sweeten <hsweeten@visionengravers.com>
>>> +Description:
>>> +		Sets the PWM duty cycle in nanoseconds.
>>=20
>> Sorry, I should've been more specific before. I'd like this to be named
>> duty_cycle. We now have the pwm_{set,get}_duty_cycle() accessors and I'd
>> like to eventually use the spelled-out form consistently.

Ok. I'll change this.

>>> +config PWM_SYSFS
>>> +	bool "/sys/class/pwm/... (sysfs interface)"
>>> +	depends on SYSFS
>>> +	help
>>> +	  Say Y here to provide a sysfs interface to control PWMs.
>>> +
>>> +	  For every instance of a PWM device there is a pwmchipN directory
>>> +	  created in /sys/class/pwm. Use the export attribute to request
>>> +	  a PWM to be accessible from userspace and the unexport attribute
>>> +	  to return the PWM to the kernel. Each exported PWM will have a
>>> +	  pwmX directory in the pwmchipN it is associated with.
>>=20
>> I have a small quibble with this. Introducing options like this make it
>> increasingly difficult to compile-test all the various combinations, so
>> I'd like to see this converted to a form that will play well with the
>> IS_ENABLED() macro. We already have the same issue with DEBUG_FS, only
>> to a lesser degree because it doesn't have an additional PWM-specific
>> Kconfig option.
>>=20
>> In order not to burden you with too much work, one option for now would
>> be to unconditionally build the sysfs.c file and use something along
>> these lines in pwmchip_sysfs_{,un}export():
>>=20
>> 	if (!IS_ENABLED(CONFIG_PWM_SYSFS))
>> 		return;
>>=20
>> Which should allow the compiler to throw away all PWM_SYSFS-related
>> code in that file, leaving an empty function.
>
>
> Won't that also cause the compiler to spew a bunch of warnings about
> unreachable code in the !CONFIG_PWM_SYSFS case? We have the
> unreachable() macro, but that isn't supported nicely by all compilers.
>
> If CONFIG_SYSFS is not enabled and sysfs.c is using functions that now
> do not exist, that will cause compile errors, since the compiler will
> still attempt to compile all of the code, even though it will remove
> most of it after doing so.
>
> Also, any functions that are extern will also end up generating empty
> functions in the kernel binary (static linkage functions should
> disappear completely). This is obviously very negligible in size,
> but using a proper Kconfig option results in zero size if the option
> is compiled out.
>
>> It's not the optimal
>> solution, which would require the sysfs code to go into core.c and be
>> conditionalized there, but it's good enough. I can always go and clean
>> up that code later (maybe doing the same for DEBUG_FS while at it).
>>
>> The big advantage of this is that we get full compile coverage of the
>> sysfs interface, whether it's enabled or not. Calling an empty function
>> once when the chip is registered is an acceptable overhead.
>
> Why not just make CONFIG_PWM_SYSFS default y, so that if CONFIG_SYSFS is
> enabled (which should be true for the vast majority of test configs) that
> pwm sysfs is also enabled?
>
> The IS_ENABLED method just seems very messy for a very small gain.

How about removing the Kconfig option and just doing:

obj-$(CONFIG_SYSFS)			+=3D sysfs.o

This way the PWM sysfs interface is always compiled and included in the bui=
ld
as long as CONFIG_SYSFS is enabled. The check in the header would change to

#ifdef CONFIG_SYSFS
void pwmchip_sysfs_export(struct pwm_chip *chip);
void pwmchip_sysfs_unexport(struct pwm_chip *chip);
#else
static inline void pwmchip_sysfs_export(struct pwm_chip *chip)
{
}

static inline void pwmchip_sysfs_unexport(struct pwm_chip *chip)
{
}
#endif /* CONFIG_SYSFS */

So, no IS_ENABLED or #ifdef'ery in the source file.

I'll make the change and post a v5 shortly.

Regards,
Hartley
