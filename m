From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [Intel-gfx] [PATCH 6/8] drivers/pwm: Add Crystalcove (CRC) PWM
 driver
Date: Sat, 20 Jun 2015 13:23:22 +0200
Message-ID: <1434799402.19497.47.camel@x220>
References: <1430316005-16480-1-git-send-email-shobhit.kumar@intel.com>
	 <1430316005-16480-7-git-send-email-shobhit.kumar@intel.com>
	 <1430428322.2187.24.camel@x220>
	 <CAAbrOmc-71MO2N9sezbOONPAf8_XSCOtHBSGD9AS9hOk0vsE=A@mail.gmail.com>
	 <1434652916.2385.124.camel@x220>
	 <CAAbrOmdGesnA+-1gz8mAWFgpSwP-R-=CZ0WjBwLamMT0f_X6bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAAbrOmdGesnA+-1gz8mAWFgpSwP-R-=CZ0WjBwLamMT0f_X6bw@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Shobhit Kumar <kumar@shobhit.info>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Shobhit Kumar <shobhit.kumar@intel.com>, linux-pwm <linux-pwm@vger.kernel.org>, Jani Nikula <jani.nikula@intel.com>, Samuel Ortiz <sameo@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, David Airlie <airlied@linux.ie>, Povilas Staniulis <wdmonster@gmail.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-gpio <linux-gpio@vger.kernel.org>, Chih-Wei Huang <cwhuang@android-x86.org>, Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pwm@vger.kernel.org

[Added Paul Gortmaker.]

Hi Shobhit,

On Fri, 2015-06-19 at 12:16 +0530, Shobhit Kumar wrote:
> So what is the exact big problem with this ?

The main problem I have is that it's hard to read a submitter's mind.
And, I think, in cases like this we need to know if the submitter just
made some silly mistake or that the mismatch (between Kconfig type and
code) was intentional. So each time such a mismatch is spotted the
submitter ought to be asked about it.

(I'd guess that one or two new drivers are submitted _each_ day. And
these mismatches are quite common. I'd say I receive answers like:
- "Oops, yes bool should have been tristate"; or
- "Oops, forgot to clean up after noticing tristate didn't work"; or
- "I just copy-and-pasted a similar driver, the module stuff isn't
  actually needed"
at least once a week. Not sure, I don't keep track of this stuff.)

Furthermore, it appears that Paul Gortmaker is on a mission to, badly
summarized, untangle the module and init code. See for instance
https://lkml.org/lkml/2015/5/28/809 and
https://lkml.org/lkml/2015/5/31/205 .

Now, I don't know whether (other) Paul is bothered by these MODULE_*
macros. But Paul did submit a series that adds
builtin_platform_driver(), see https://lkml.org/lkml/2015/5/10/131 .
That new macro ensures built-in only code doesn't have to use
module_platform_driver(), which your patch also uses. So perhaps Paul
can explain some of the non-obvious issues caused by built-in only code
using module specific constructs.

> I can anyway shove out these macros to end the discussion.

I'd rather convince you than annoy you into doing as I suggested.

> BTW whether you  buy the argument or not, please do treat yourself
> with ice cream for being able to make such a comment.

Will do.

Thanks,


Paul Bolle

--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
