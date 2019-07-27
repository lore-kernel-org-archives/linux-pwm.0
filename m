From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: Re: [PATCH 5/6] pwm: sun4i: Add support to output
 source clock directly
Date: Sat, 27 Jul 2019 22:54:32 +0800
Message-ID: <CAGb2v65a9jF3QsEQgTim_XxXjhd9K0KwDRxtqYMqsiy2yWLeBg@mail.gmail.com>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <20190726184045.14669-6-jernej.skrabec@siol.net> <20190727105008.he35sixfvoyl2lm7@flea.home>
 <4063694.66Ui2fGJfo@jernej-laptop>
Reply-To: wens-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCMILY6JWQBBBNWL6HUQKGQELDKVECQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <4063694.66Ui2fGJfo@jernej-laptop>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
Cc: Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Sat, Jul 27, 2019 at 10:28 PM Jernej =C5=A0krabec <jernej.skrabec@siol.n=
et> wrote:
>
> Dne sobota, 27. julij 2019 ob 12:50:08 CEST je Maxime Ripard napisal(a):
> > On Fri, Jul 26, 2019 at 08:40:44PM +0200, Jernej Skrabec wrote:
> > > PWM core has an option to bypass whole logic and output unchanged sou=
rce
> > > clock as PWM output. This is achieved by enabling bypass bit.
> > >
> > > Note that when bypass is enabled, no other setting has any meaning, n=
ot
> > > even enable bit.
> > >
> > > This mode of operation is needed to achieve high enough frequency to
> > > serve as clock source for AC200 chip, which is integrated into same
> > > package as H6 SoC.
> > >
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
> >
> > It doesn't seem to be available on the A10 (at least) though. The A13
> > seem to have it, so you should probably check that, and make that
> > conditional to the compatible if not available on all of them.
>
> Ok, can you suggest the name for the quirk? "has_bypass" is suspiciously
> similar to "has_prescaler_bypass".

has_direct_mod_clk_output?

> Also, how to name these sun4i_pwm_data structures? Now that there are (wi=
ll
> be) three new quirks, name of the structure would be just too long, like
> "sun50i_pwm_dual_prescaler_bypass_clk_rst_bypass".

Just use the SoC model. Any later ones that have the same quirks will likel=
y
use the same compatible string anyway.

ChenYu

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To view this discussion on the web, visit https://groups.google.com/d/msgid=
/linux-sunxi/CAGb2v65a9jF3QsEQgTim_XxXjhd9K0KwDRxtqYMqsiy2yWLeBg%40mail.gma=
il.com.
