From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [Intel-gfx] [PATCH 6/8] drivers/pwm: Add Crystalcove (CRC) PWM
 driver
Date: Sat, 20 Jun 2015 14:04:36 -0400
Message-ID: <20150620180435.GG16386@windriver.com>
References: <1430316005-16480-1-git-send-email-shobhit.kumar@intel.com>
 <1430316005-16480-7-git-send-email-shobhit.kumar@intel.com>
 <1430428322.2187.24.camel@x220>
 <CAAbrOmc-71MO2N9sezbOONPAf8_XSCOtHBSGD9AS9hOk0vsE=A@mail.gmail.com>
 <1434652916.2385.124.camel@x220>
 <CAAbrOmdGesnA+-1gz8mAWFgpSwP-R-=CZ0WjBwLamMT0f_X6bw@mail.gmail.com>
 <1434799402.19497.47.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1434799402.19497.47.camel@x220>
Sender: linux-gpio-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Shobhit Kumar <kumar@shobhit.info>, Shobhit Kumar <shobhit.kumar@intel.com>, linux-pwm <linux-pwm@vger.kernel.org>, Jani Nikula <jani.nikula@intel.com>, Samuel Ortiz <sameo@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, David Airlie <airlied@linux.ie>, Povilas Staniulis <wdmonster@gmail.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-gpio <linux-gpio@vger.kernel.org>, Chih-Wei Huang <cwhuang@android-x86.org>, Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pwm@vger.kernel.org

[Re: [Intel-gfx] [PATCH 6/8] drivers/pwm: Add Crystalcove (CRC) PWM driver] On 20/06/2015 (Sat 13:23) Paul Bolle wrote:

> [Added Paul Gortmaker.]
> 
> Hi Shobhit,
> 
> On Fri, 2015-06-19 at 12:16 +0530, Shobhit Kumar wrote:
> > So what is the exact big problem with this ?
> 
> The main problem I have is that it's hard to read a submitter's mind.
> And, I think, in cases like this we need to know if the submitter just
> made some silly mistake or that the mismatch (between Kconfig type and
> code) was intentional. So each time such a mismatch is spotted the
> submitter ought to be asked about it.
> 
> (I'd guess that one or two new drivers are submitted _each_ day. And
> these mismatches are quite common. I'd say I receive answers like:
> - "Oops, yes bool should have been tristate"; or
> - "Oops, forgot to clean up after noticing tristate didn't work"; or
> - "I just copy-and-pasted a similar driver, the module stuff isn't
>   actually needed"
> at least once a week. Not sure, I don't keep track of this stuff.)
> 
> Furthermore, it appears that Paul Gortmaker is on a mission to, badly
> summarized, untangle the module and init code. See for instance
> https://lkml.org/lkml/2015/5/28/809 and
> https://lkml.org/lkml/2015/5/31/205 .
> 
> Now, I don't know whether (other) Paul is bothered by these MODULE_*
> macros. But Paul did submit a series that adds

Yes, I agree that it would be nice to not see these mismatches,
regardless of whether we can get away with it or not.

> builtin_platform_driver(), see https://lkml.org/lkml/2015/5/10/131 .
> That new macro ensures built-in only code doesn't have to use
> module_platform_driver(), which your patch also uses. So perhaps Paul
> can explain some of the non-obvious issues caused by built-in only code
> using module specific constructs.

In  https://lkml.org/lkml/2015/5/10/125 I'd written:

  There are several downsides to this:
  1) The code can appear modular to a reader of the code, and they
     won't know if the code really is modular without checking the
     Makefile and Kconfig to see if compilation is governed by a
     bool or tristate.
  2) Coders of drivers may be tempted to code up an __exit function
     that is never used, just in order to satisfy the required three
     args of the modular registration function.
  3) Non-modular code ends up including the <module.h> which increases
     CPP overhead that they don't need.
  4) It hinders us from performing better separation of the module
     init code and the generic init code.
  
The nature of linux means that thousands of developers are reading the
code every day -- so I think that there is a genuine value in having the
code convey a clear message on how it was designed to be used.  Only
using module related headers/macros for genuinely modular code helps us
(albeit in a small way) towards achieving that.

Looking at this thread, I see that one of the reasons given for this
code's ambiguous module vs. built-in identity was the observation of a
similar identity crisis of the related INTEL_SOC_PMIC code. Does that
not back up the point above about the value in having the code speak for
itself?  So IMHO we probably should clarify the PMIC code vs. adding
another example that looks just like it.

Paul.
--

> 
> > I can anyway shove out these macros to end the discussion.
> 
> I'd rather convince you than annoy you into doing as I suggested.
> 
> > BTW whether you  buy the argument or not, please do treat yourself
> > with ice cream for being able to make such a comment.
> 
> Will do.
> 
> Thanks,
> 
> 
> Paul Bolle
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
