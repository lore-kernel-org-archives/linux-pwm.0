From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v6 3/4] ARM: mvebu: Enable SENSORS_PWM_FAN in defconfig
Date: Tue, 23 May 2017 16:00:25 +0200
Message-ID: <87lgpny8p2.fsf@free-electrons.com>
References: <20170414154056.32055-1-ralph.sennhauser@gmail.com>
        <20170414154056.32055-4-ralph.sennhauser@gmail.com>
        <CACRpkda6P026U4pBXPuEJ=cYu+Hz9N_-snXcOXr5c0Q9g4jBig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkda6P026U4pBXPuEJ=cYu+Hz9N_-snXcOXr5c0Q9g4jBig@mail.gmail.com>
        (Linus Walleij's message of "Mon, 24 Apr 2017 11:20:02 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

Hi,
 
 On lun., avril 24 2017, Linus Walleij <linus.walleij@linaro.org> wrote:

> On Fri, Apr 14, 2017 at 5:40 PM, Ralph Sennhauser
> <ralph.sennhauser@gmail.com> wrote:
>
>> From: Andrew Lunn <andrew@lunn.ch>
>>
>> Now that the GPIO driver also supports PWM operation, enable the PWM
>> framework and fan driver in mvebu_v7_defconfig.
>>
>> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
>> URL: https://patchwork.ozlabs.org/patch/427297/
>> [Ralph Sennhauser: add fan driver to defconfig]
>> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
>> Tested-by: Andrew Lunn <andrew@lunn.ch>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Please funnel this through ARM SoC.

Applied on mvebu/defconfig

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
