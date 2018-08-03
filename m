From: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 0/2] gpio: mvebu: Add support for multiple PWM lines
Date: Fri, 03 Aug 2018 11:36:44 +0200
Message-ID: <87sh3vbxlf.fsf@bootlin.com>
References: <1532114623-81911-1-git-send-email-aditya@kobol.io>
        <CACRpkdbiAkt6hT+LeRXCjWDZwjeYDF-e3sckMOWqnL2rdqLDug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbiAkt6hT+LeRXCjWDZwjeYDF-e3sckMOWqnL2rdqLDug@mail.gmail.com>
        (Linus Walleij's message of "Sun, 29 Jul 2018 22:58:16 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: aditya@kobol.io, Linus Walleij <linus.walleij@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, Ralph Sennhauser <ralph.sennhauser@gmail.com>, Richard Genoud <richard.genoud@gmail.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, gauthier@kobol.io, alban.browaeys@gmail.com, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Hi Linus and Adita
 
 On dim., juil. 29 2018, Linus Walleij <linus.walleij@linaro.org> wrote:

> Hoping for some review from Gergory, Ralph or Richard who all seem
> to use this driver!

Would it be possible to resend the series adding me in CC?  I would
like to comment the patches, but unfortunately it seems that I was in
none of the mailing list where the series had been sent.

I found the patches on patchwork, and started to have a look on it for
example, in the patch "gpio: mvebu: Add support for multiple PWM lines
per GPIO chip", I wonder why the id is stored as it was not used at all.

Having the patch inlined in an email would male the review easier.

Thanks,

Gregory

>
> Yours,
> Linus Walleij
>
> On Fri, Jul 20, 2018 at 9:24 PM Aditya Prayoga <aditya@kobol.io> wrote:
>>
>> Hi everyone,
>>
>> Helios4, an Armada 388 based NAS SBC, provides 2 (4-pins) fan connectors.
>> The PWM pins on both connector are connected to GPIO on bank 1. Current gpio-
>> mvebu does not allow more than one PWM on the same bank.
>>
>> Aditya
>>
>> ---
>>
>> Aditya Prayoga (2):
>>   gpio: mvebu: Add support for multiple PWM lines per GPIO chip
>>   gpio: mvebu: Allow to use non-default PWM counter
>>
>>  drivers/gpio/gpio-mvebu.c | 111 ++++++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 92 insertions(+), 19 deletions(-)
>>
>> --
>> 2.7.4
>>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
