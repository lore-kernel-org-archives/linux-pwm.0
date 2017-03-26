From: Ralph Sennhauser <ralph.sennhauser-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 4/4] mvebu: wrt1900ac: Use pwm-fan rather than
 gpio-fan
Date: Sun, 26 Mar 2017 23:05:58 +0200
Message-ID: <20170326230558.6b6c4ec6@gmail.com>
References: <20170324141815.7252-1-ralph.sennhauser@gmail.com>
 <20170324141815.7252-5-ralph.sennhauser@gmail.com>
 <20170324143505.GK28518@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170324143505.GK28518-g2DYL2Zd6BY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Imre Kaloz <kaloz-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Fri, 24 Mar 2017 15:35:05 +0100
Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org> wrote:

> > +	pwm_fan {
> >  		/* SUNON HA4010V4-0000-C99 */
> > -		compatible = "gpio-fan";
> > -		gpios = <&gpio0 24 0>;
> >  
> > -		gpio-fan,speed-map = <0    0
> > -				      4500 1>;
> > +		compatible = "pwm-fan";
> > +		pwms = <&gpio0 24 4000 0>;  
> 
> Hi Ralph
> 
> I believe this last 0 is the flags parameter. Now that we have
> #pwm-cells = 1, i think this last 0 should be dropped.
> 
> 	  Andrew

Hi Andrew,

isn't the 4000 (period?) pwm-cell #2 and 0 (flags?) pwm-cell #3? I
actually expect "pwms = <&gpio0 24>;" here or "#pwm-cells = <2>;"

Ralph
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
