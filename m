From: Shobhit Kumar <kumar@shobhit.info>
Subject: Re: [Intel-gfx] [v2 4/7] mfd: intel_soc_pmic_core: ADD PWM lookup
 table for CRC PMIC based PWM
Date: Thu, 25 Jun 2015 18:03:15 +0530
Message-ID: <CAAbrOme=+NaTODZ278wggwJmJ=4RcvRYgrEVpfKPfWoe4fqKjA@mail.gmail.com>
References: <1434970465-12687-1-git-send-email-shobhit.kumar@intel.com>
	<1434970465-12687-5-git-send-email-shobhit.kumar@intel.com>
	<5587EB7A.5090402@gmail.com>
	<20150622141908.GM25769@phenom.ffwll.local>
	<20150623071921.GE3245@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20150623071921.GE3245@x1>
Sender: linux-gpio-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Varka Bhadram <varkabhadram@gmail.com>, Shobhit Kumar <shobhit.kumar@intel.com>, linux-pwm <linux-pwm@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-gpio <linux-gpio@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Paul Bolle <pebolle@tiscali.nl>, Samuel Ortiz <sameo@linux.intel.com>, Povilas Staniulis <wdmonster@gmail.com>, Jani Nikula <jani.nikula@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Brain WrecK <bloften80@gmail.com>, David Airlie <airlied@linux.ie>, Chih-Wei Huang <cwhuang@android-x86.org>, Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>
List-Id: linux-pwm@vger.kernel.org

On Tue, Jun 23, 2015 at 12:49 PM, Lee Jones <lee.jones@linaro.org> wrot=
e:
> On Mon, 22 Jun 2015, Daniel Vetter wrote:
>
>> On Mon, Jun 22, 2015 at 04:33:22PM +0530, Varka Bhadram wrote:
>> > Hi Shobhit Kumar,
>> >
>> > On 06/22/2015 04:24 PM, Shobhit Kumar wrote:
>> >
>> > >On some BYT PLatform the PWM is controlled using CRC PMIC. Add a =
lookup
>> > >entry for the same to be used by the consumer (Intel GFX)
>> > >
>> > >v2: Remove the lookup table on driver unload (Thierry)
>> > >
>> > >v3: Correct the subject line (Lee jones)
>> >
>> > This part should only describe what this is about..
>> >
>> > Don't put this patch change history over here.
>> > Include this change history after
>> > ...
>> > Signed-off-by: Author <email>
>> > ---
>> >
>> > >CC: Samuel Ortiz <sameo@linux.intel.com>
>> > >Cc: Linus Walleij <linus.walleij@linaro.org>
>> > >Cc: Alexandre Courbot <gnurou@gmail.com>
>> > >Cc: Thierry Reding <thierry.reding@gmail.com>
>> > >Acked-by: Lee Jones <lee.jones@linaro.org>
>> > >Signed-off-by: Shobhit Kumar <shobhit.kumar@intel.com>
>> > >---
>> >
>> > Here you add this change history so that after applying this
>> > will not be the part of your commit description.
>> >
>> > This comment is applicable for all of your patches.
>>
>> It's honestly a per-maintainer thing and hard to tell who wants what=
 ...
>> Personally I do want to include the patch changelog in the commit me=
ssage.
>
> The patch change-log should go below the '---'.  There are very few
> (weird ;) ) Maintainers who like to see them in the commit log.

To satisfy everybody, for the last two patches for intel-gfx, I will
keep the version history as is, for others, I will move it down as
suggested. Will push all again as new series after addressing all
comments.

Regards
Shobhit

>
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/intel-gfx
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
