From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v6 4/4] ARM: dts: armada-xp: Use pwm-fan rather than gpio-fan
Date: Tue, 23 May 2017 15:53:34 +0200
Message-ID: <87poezy90h.fsf@free-electrons.com>
References: <20170414154056.32055-1-ralph.sennhauser@gmail.com>
        <20170414154056.32055-5-ralph.sennhauser@gmail.com>
        <CACRpkdbVVf91NhbiaHxo6doUdGH6thVsjoUom4nYQRhj_qkz3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbVVf91NhbiaHxo6doUdGH6thVsjoUom4nYQRhj_qkz3g@mail.gmail.com>
        (Linus Walleij's message of "Mon, 24 Apr 2017 11:20:31 +0200")
Sender: linux-gpio-owner@vger.kernel.org
To: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

Hi
 
 On lun., avril 24 2017, Linus Walleij <linus.walleij@linaro.org> wrote:

> On Fri, Apr 14, 2017 at 5:40 PM, Ralph Sennhauser
> <ralph.sennhauser@gmail.com> wrote:
>
>> From: Andrew Lunn <andrew@lunn.ch>
>>
>> The mvebu GPIO driver can also perform PWM on some pins. Use the pwm-fan
>> driver to control the fan of the WRT1900AC, giving us finer grained control
>> over its speed and hence noise.
>>
>> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
>> URL: https://patchwork.ozlabs.org/patch/427291/
>> [Ralph Sennhauser: drop flags paramter from pwms, no longer used]
>> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
>> Tested-by: Andrew Lunn <andrew@lunn.ch>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Please funnel this through ARM SoC.

Applied on mvebu/dt

Thanks,

Gregory
>
> Yours,
> Linus Walleij

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
