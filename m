From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v6 2/4] ARM: dts: mvebu: Add PWM properties to .dtsi files
Date: Tue, 23 May 2017 15:53:03 +0200
Message-ID: <87tw4by91c.fsf@free-electrons.com>
References: <20170414154056.32055-1-ralph.sennhauser@gmail.com>
        <20170414154056.32055-3-ralph.sennhauser@gmail.com>
        <CACRpkdZE0wnotF+OdAmutJcU9JSE_LxNd7Lz7yXqcn_bq5VqgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdZE0wnotF+OdAmutJcU9JSE_LxNd7Lz7yXqcn_bq5VqgQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
        (Linus Walleij's message of "Mon, 24 Apr 2017 11:19:32 +0200")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ralph Sennhauser <ralph.sennhauser-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-gpio@vger.kernel.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, "linux-pwm@vger.kernel.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree@vger.kernel.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel@vger.kernel.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hi,
 
 On lun., avril 24 2017, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:

> On Fri, Apr 14, 2017 at 5:40 PM, Ralph Sennhauser
> <ralph.sennhauser-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
>> From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
>>
>> Add properties to the GPIO nodes to allow them to be also used as PWM
>> lines.
>>
>> Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
>> URL: https://patchwork.ozlabs.org/patch/427294/
>> [Ralph Sennhauser: Add new compatible string marvell,armada-370-xp-gpio]
>> Signed-off-by: Ralph Sennhauser <ralph.sennhauser-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Tested-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
>
> Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
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
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
