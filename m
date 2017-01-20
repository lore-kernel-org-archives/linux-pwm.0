From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] pwm: lpss: Make builtin so that i915 can find the
 pwm_backlight
Date: Fri, 20 Jan 2017 10:48:52 +0100
Message-ID: <280ead58-d2c9-f36e-cbfb-90cd7ad5b6f3@redhat.com>
References: <20170119175830.3754-1-hdegoede@redhat.com>
 <20170120070333.GD4894@ulmo.ba.sec> <8737gei2fp.fsf@intel.com>
 <20170120085617.GG4894@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55640 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751547AbdATJ50 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 20 Jan 2017 04:57:26 -0500
In-Reply-To: <20170120085617.GG4894@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>
Cc: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hi,

On 20-01-17 09:56, Thierry Reding wrote:
> On Fri, Jan 20, 2017 at 10:02:50AM +0200, Jani Nikula wrote:
>> On Fri, 20 Jan 2017, Thierry Reding <thierry.reding@gmail.com> wrote:
>>> On Thu, Jan 19, 2017 at 06:58:30PM +0100, Hans de Goede wrote:
>>>> The primary consumer of the lpss pwm is the i915 kms driver,
>>>> the i915 driver does not support get_pwm returning -EPROBE_DEFER and
>>>> its init is very complex making this is almost impossible to fix.
>>>>
>>>> This commit changes the PWM_LPSS Kconfig from a tristate to a bool, so
>>>> that when the i915 driver loads the lpss pwm will be available avoiding
>>>> the -EPROBE_DEFER issue. Note that this is identical to how the same
>>>> problem was solved for the pwm-crc driver, which is used by the i915
>>>> driver on other platforms.
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> Acked-by: Jani Nikula <jani.nikula@intel.com>
>>>> ---
>>>> Changes in v2:
>>>> -Drop the pwm_add_table call (this has been moved to the acpi_lpss driver)
>>>> ---
>>>>  drivers/pwm/Kconfig | 12 +++---------
>>>>  1 file changed, 3 insertions(+), 9 deletions(-)
>>>
>>> For the record I think this is completely wrong and i915 should be
>>> taught how to deal with -EPROBE_DEFER. We've gone through a lot of
>>> pain to clean up this kind of init-level ordering on other devices
>>> and the result is, in my opinion, a *lot* better than what we had
>>> before. It'd be shame to see i915 backpedal on that.
>>>
>>> That said, if everyone else thinks that it really can't be done and
>>> this workaround is the best way forward, I'll just shut up about it
>>> and stop caring.
>>
>> Superficially, it is, of course, easy to agree we should handle deferred
>> probing.
>>
>> i915 is a complex driver for complex hardware. We require a ton of
>> initialization before we even get to the point we realize we might need
>> the PWM. Naturally, we'd need to gracefully tear all that down for
>> -EPROBE_DEFER handling. And we've been slowly working towards this;
>> we've even added injected probe failures in CI to test this. But we're
>> not there yet. This patch seems like a rather simple workaround for the
>> time being.
>>
>> There are two other related things I wonder about.
>>
>> I see module reloading mostly as a developer feature. I don't think I'm
>> alone in that. You just don't recommend anyone doing module reloads in a
>> production environment. However, deferred probing is in some ways more
>> demanding than module reload, because it needs to gracefully handle
>> partial probes. Yet that is the solution of choice for init
>> ordering. Makes you wonder.
>
> Well, there have been proposals in the past to get rid of deferred
> probing by replacing it with something more formal, but it's a fairly
> difficult issue to solve. While deferred probing is indeed a rather
> heavy-weight solution, it's one that's proven to work well enough for
> most of the world.
>
> Also gracefully handling partial probes is something you need in most
> cases anyway. Typically the easiest solution is to make sure to run all
> the code that could possibly fail as early as possible, like Hans had
> suggested, so that you need to unwind as little as possible.
>
>> Another thing that comes up a lot with graphics is that people really do
>> appreciate any crappy degraded image over a black screen. If the PWM
>> never shows up, all the external screens will be black in addition to
>> the embedded display. We're always torn between failing fast
>> vs. plunging on despite failures.
>
> Yes, I see how deferred probe would get in the way here. To be fair,
> deferred probing was never meant to solve this kind of use-case. One
> of the reasons why it is so heavy-weight is that drivers can usually
> not continue without the resources they're trying to get.
>
> In this particular case, however, only a very small subset of the driver
> relies on the PWM, so it's more of an optional, nice to have, resource
> rather than an essential one.
>
>> That said, I suppose there could be an alternative to handling pwm_get()
>> failures at probe. We could just go on with our init, but schedule a
>> retry later. Perhaps a bit hacky, but it would address both of the
>> concerns above. Again, this patch seems a simple workaround in the mean
>> time.
>
> I don't think that's hacky at all. In fact I think it's a really nice
> solution for this particular case and could probably be a good fit for
> other use-cases as well.
>
> As for adding a simple workaround in the meantime, is that really
> necessary? This doesn't really fix any bugs, right?

It fixes the bug of not being able to control the backlight on many
cherrytrail devices.

> Its just that new
> hardware may not work properly, isn't it? I'm somewhat reluctant to
> temporarily add this workaround because I know Paul Gortmaker will
> immediately send out a patch to make the driver use builtin_{pci,
> platform}_driver and all of a sudden we've got a bunch of things to
> untangle because of a "simple workaround".
>
> Hans, do you think you could find some time to at least investigate
> whether or not Jani's proposal above would be a viable option that
> wouldn't take ages to implement?

The whole backlight situation on x86 is much more complicated then
it has any right to be I'm afraid. If the i915 driver does not register
a backlight interface right away, then the acpi-video driver will
register a backlight interface instead (*), which may or may not work
and if userspace manages to try and use that interface before the
i915 driver gets around to register its own interface the firmware
may mess up some i915 or pwm_lpss register settings in such a way
that the backlight will later never work, flicker, be inverted,
whatever.

*) Which will get unregistered again when the i915 driver does
register its own backlight later, yes I kid you not.

The whole firmware interface to the backlight stuff on x86 is
a horrendous mess (I know I've spend a significant amount of time
the last couple of years making it mostly work and adding dmi based
quirks where necessary).

 > If it's excessively complicated to do,

It is probably doable, but I'm very much against trick with this
because of what I've written above. Ah this also brings up another
problem with the i915 driver init order. On systems without an
i915 vbios opregion, the acpi-video bus driver will immediately
enumerate that "bus" and register e.g. backlight device(s) based
on acpi tables. But when an i915 vbios opregion is present,
the acpi-video bus modules' init function will just return 0 and
expects the i915 driver to call its probe function later, after
the i915 opregion's init function has run, because otherwise
bad things may happen.

I've not yet checked if this call to acpi_video's probe function
happens before or after we try to get the pwm, but if it happens
before, undoing that is also a problem ...

 > I'm okay with this patch, though you may want to do the module_*
> to builtin_* conversion while at it to save Paul the extra work. And
> maybe add a comment somewhere that this is meant to be a temporary
> workaround until i915 can deal with this more nicely?

I'm fine with doing a v3 with a comment, how about putting that comment
right at all the module* stuff and explain there that that is to
stay as the builtin only status is meant to be temporary ?

Regards,

Hans
