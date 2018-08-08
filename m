From: Aditya Prayoga <aditya@kobol.io>
Subject: Re: [PATCH RESEND 2/2] gpio: mvebu: Allow to use non-default PWM counter
Date: Wed, 8 Aug 2018 18:40:09 +0700
Message-ID: <CAFTRUBdSkLWLi1QJ-303JFZFM83z0UugEDUbF1coTn7RT5EMNA@mail.gmail.com>
References: <1533522556-55055-1-git-send-email-aditya@kobol.io>
 <1533522556-55055-3-git-send-email-aditya@kobol.io> <20180806135257.GB6584@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180806135257.GB6584@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: andrew@lunn.ch
Cc: linux-gpio@vger.kernel.org, richard.genoud@gmail.com, gregory.clement@bootlin.com, Gauthier Provost <gauthier@kobol.io>, alban.browaeys@gmail.com, thierry.reding@gmail.com, linus.walleij@linaro.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Dennis Gilmore <dennis@ausil.us>, ralph.sennhauser@gmail.com
List-Id: linux-pwm@vger.kernel.org

On Mon, Aug 6, 2018 at 8:53 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Aug 06, 2018 at 10:29:16AM +0800, Aditya Prayoga wrote:
> > On multiple PWM lines, if the other PWM counter is unused, allocate it
> > to next PWM request. The priority would be:
> > 1. Default counter assigned to the bank
> > 2. Unused counter that is assigned to other bank
> > 3. Fallback to default counter
> >
> > For example on second bank there are three PWM request, first one would
> > use default counter (counter B), second one would try to use counter A,
> > and the third one would use counter B.
>
> Hi Aditya
>
> There are only two PWM counters for all the GPIO lines. So you cannot
> support 3 PWM requests. You have to enforce a maximum of two PWMs.
>
> When i implemented this PWM code, i only needed one PWM. So it took
> the easy option. GPIO bank 0 uses counter A, GPIO bank1 uses counter
> B. For the hardware you have, this is not sufficient, so you need to
> generalise this. Any PWM can use any counter, whatever is available
> when the PWM is requested.

Hi Andrew

Understood. I will change it in next version.

> Rather than have a linked list of PWM, i think it would be better to
> have a static array of two mvebu_pwm structures. Index 0 uses counter
> A, index 1 uses counter B. You can then keep with the concept of
> pwm->pgiod != NULL means the counter is in use. The request() call can
> then find an unused PWM, set pwm->gpiod, and point mvchip->mvpwm to
> one of the two static instances.

That was my initial idea to use static array but then I thought maybe
I could generalise it for future device by using linked list.

Regards,

Aditya
>
>     Andrew
