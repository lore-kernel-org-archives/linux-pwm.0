From: Hao Zhang <hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 4/4] ARM: PWM: add allwinner sun8i pwm support.
Date: Mon, 14 May 2018 22:45:44 +0800
Message-ID: <CAJeuY7-Dz1u9J8GMu=OdzJ2cJUnE3wEobJoQz6RV-ibjBjoW4A@mail.gmail.com>
References: <20180225135308.GA14561@arx-s1> <20180226090038.etk5q4pd4rl5dvf6@flea.lan>
Reply-To: hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDKITZOARQMBBGOC43LQKGQE6SH62YQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20180226090038.etk5q4pd4rl5dvf6-ZC1Zs529Oq4@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Claudiu Beznea <Claudiu.Beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

2018-02-26 17:00 GMT+08:00 Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>:
> Hi,
>
> Thanks for respinning this serie. It looks mostly good, but you still
> have a quite significant number of checkpatch (--strict) warnings that
> you should address.

Thanks for reviews :) ,i'm sorry for that, it will be fixed next time.
and, besides, in what situation were the checkpatch warning can be ignore=
=EF=BC=9F

>
> On Sun, Feb 25, 2018 at 09:53:08PM +0800, hao_zhang wrote:
>> +#define CAPTURE_IRQ_ENABLE_REG       0x0010
>> +#define CFIE(ch)     BIT(ch << 1 + 1)
>> +#define CRIE(ch)     BIT(ch << 1)
>
> You should also put your argument between parentheses here (and in all
> your other macros).

Do you mean like this ?
#define CFIE(ch)     BIT((ch) << 1 + 1)
#define CRIE(ch)     BIT((ch) << 1)

>
>> +static const u16 div_m_table[] =3D {
>> +     1,
>> +     2,
>> +     4,
>> +     8,
>> +     16,
>> +     32,
>> +     64,
>> +     128,
>> +     256
>> +};
>
> If this is just a power of two, you can use either the power of two /
> ilog2 to switch back and forth, instead of using that table.

I think using table is more explicit and extended...

>
>> +static int sun8i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
>> +             struct pwm_state *state)
>> +{
>> +     int ret;
>> +     struct sun8i_pwm_chip *sun8i_pwm =3D to_sun8i_pwm_chip(chip);
>> +     struct pwm_state cstate;
>> +
>> +     pwm_get_state(pwm, &cstate);
>> +     if (!cstate.enabled) {
>> +             ret =3D clk_prepare_enable(sun8i_pwm->clk);
>> +             if (ret) {
>> +                     dev_err(chip->dev, "Failed to enable PWM clock\n")=
;
>> +                     return ret;
>> +             }
>> +     }
>> +
>> +     spin_lock(&sun8i_pwm->ctrl_lock);
>
> What do you need that spinlock for? Can you use a mutex instead?
It should be remove.
>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
