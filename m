From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 0/2] pwm-backlight: switch to gpiod interface (part 1)
Date: Thu, 27 Mar 2014 10:04:37 +0900
Message-ID: <000801cf4958$8678ff20$936afd60$%han@samsung.com>
References: <1393480414-19473-1-git-send-email-acourbot@nvidia.com>
 <CAAVeFuKE163O3Kcdy-WCCEesJMCQ-fcLe8Op5f=VE7ZovFptqA@mail.gmail.com>
 <CAK5ve-K7-Qk-VX33ZMWh3WEYOQND_o_TG6Hk28Y7r8dVgVtg9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAK5ve-K7-Qk-VX33ZMWh3WEYOQND_o_TG6Hk28Y7r8dVgVtg9A@mail.gmail.com>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Bryan Wu' <cooloney@gmail.com>, 'Alexandre Courbot' <gnurou@gmail.com>
Cc: 'Alexandre Courbot' <acourbot@nvidia.com>, 'Thierry Reding' <thierry.reding@gmail.com>, 'Ben Dooks' <ben-linux@fluff.org>, 'Kukjin Kim' <kgene.kim@samsung.com>, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Jingoo Han' <jg1.han@samsung.com>
List-Id: linux-pwm@vger.kernel.org

On Thursday, March 27, 2014 9:09 AM, Bryan Wu wrote:
> On Tue, Mar 25, 2014 at 10:01 PM, Alexandre Courbot <gnurou@gmail.com> wrote:
> > Ping Thierry, can you have a look at this series? It is quite similar
> > to the same change you merged for panel-simple (although I cannot see
> > it in -next neither).
> >
> 
> I think Jingoo can help to review this as well. Jingoo, can you help
> to review. Actually it looks good to me.

Sorry, I cannot review this pwm-backlight code, I don't have
knowledge about pwm-backlight and gpiod. I think that Thierry
will review this correctly.

Best regards,
Jingoo Han

> 
> -Bryan
> 
> > On Thu, Feb 27, 2014 at 2:53 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:
> >> These two patches initiate the switch of the pwm-backlight driver to
> >> the gpiod GPIO interface, as it considerably simplifies the code.
> >>
> >> For compatibility with current users of the driver, it is still possible
> >> to pass the enable GPIO number as platform data. Two platforms are still
> >> relying on this feature (pxa/palmtc and shmobile/armadillo800eva) which
> >> will be removed as soon as its last users are switched to GPIO mapping
> >> tables.
> >>
> >> Alexandre Courbot (2):
> >>   ARM: SAMSUNG: remove gpio flags in dev-backlight
> >>   pwm-backlight: switch to gpiod interface
> >>
> >>  arch/arm/plat-samsung/dev-backlight.c |  2 -
> >>  drivers/video/backlight/pwm_bl.c      | 72 +++++++++++++++--------------------
> >>  include/linux/pwm_backlight.h         |  5 +--
> >>  3 files changed, 32 insertions(+), 47 deletions(-)
> >>
> >> --
> >> 1.9.0
