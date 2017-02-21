From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 1/4] pwm: sunxi: Code switched to regmap
 API instead of iomem.
Date: Tue, 21 Feb 2017 15:37:14 -0800
Message-ID: <20170221233714.4t2jaivwwbokbo7y@lukather>
References: <1487189167-32486-1-git-send-email-lis8215@gmail.com>
 <1487189167-32486-2-git-send-email-lis8215@gmail.com>
 <20170216175952.34qn72pi47epma37@lukather>
 <CAKNVLfa-doz_6oARF5Eg1EbKFuita34Pg2x6Jutjzt9fshUEwQ@mail.gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cydpvm455q7s2nil"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBLM6WPCQKGQEGMG66QI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <CAKNVLfa-doz_6oARF5Eg1EbKFuita34Pg2x6Jutjzt9fshUEwQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--cydpvm455q7s2nil
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Tue, Feb 21, 2017 at 09:47:43AM +0300, Siarhei Volkau wrote:
> >> +#define SUN4I_REGMAP_FIELDS(chan) {\
> >> +     [FIELD_PRESCALER] = \
> >> +             REG_FIELD(PWM_CTRL_REG, \
> >> +                       BIT_CH(PWM_PRESCAL_LSB, chan), \
> >> +                       BIT_CH(PWM_PRESCAL_MSB, chan)), \
> >> +     [FIELD_POLARITY] = \
> >> +             REG_FIELD(PWM_CTRL_REG, \
> >> +                       BIT_CH(PWM_ACT_STATE_BIT, chan), \
> >> +                       BIT_CH(PWM_ACT_STATE_BIT, chan)), \
> >> +     [FIELD_CLK_GATING] = \
> >> +             REG_FIELD(PWM_CTRL_REG, \
> >> +                       BIT_CH(PWM_CLK_GATING_BIT, chan), \
> >> +                       BIT_CH(PWM_CLK_GATING_BIT, chan)), \
> >> +     [FIELD_READY] = \
> >> +             REG_FIELD(PWM_CTRL_REG, \
> >> +                       PWM_RDY_BIT(chan), \
> >> +                       PWM_RDY_BIT(chan)), \
> >> +}
> >> +
> >
> > This is not correct, unfortunately. If someone calls that macro with
> > chan++ or chan--, it will be modified four times instead of one as the
> > caller would expect.
> 
> Ok, i will refactor that.
> I think you should know about existence of unsafe macros (like MIN
> MAX or ABS) into existing linux kernel tree, this macros can be easily
> refactored into the inline functions. Please tell me your point of view
> on that things.

This might be bad, but we also have functions for those, which should
behave properly. Anyway, I don't really expect you to fix the whole
kernel before taking that patch in :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--cydpvm455q7s2nil--
