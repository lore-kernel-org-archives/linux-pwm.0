From: Hao Zhang <hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 4/4] ARM: PWM: add allwinner sun8i pwm support.
Date: Thu, 17 May 2018 22:48:58 +0800
Message-ID: <CAJeuY79ObkssY_=SLG==7xZri10P3yWFhXC3=CUVrdQ+7cBoHA@mail.gmail.com>
References: <20180225135308.GA14561@arx-s1> <20180226090038.etk5q4pd4rl5dvf6@flea.lan>
 <CAJeuY7-Dz1u9J8GMu=OdzJ2cJUnE3wEobJoQz6RV-ibjBjoW4A@mail.gmail.com> <20180515111711.l2g4vgsal7yr6dbr@flea>
Reply-To: hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDKITZOARQMBBW5M63LQKGQEUHUIJ7A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20180515111711.l2g4vgsal7yr6dbr@flea>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Claudiu Beznea <Claudiu.Beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

2018-05-15 19:17 GMT+08:00 Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>:
> Hi,
>
> On Mon, May 14, 2018 at 10:45:44PM +0800, Hao Zhang wrote:
>> 2018-02-26 17:00 GMT+08:00 Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>:
>> > Thanks for respinning this serie. It looks mostly good, but you still
>> > have a quite significant number of checkpatch (--strict) warnings that
>> > you should address.
>>
>> Thanks for reviews :) ,i'm sorry for that, it will be fixed next
>> time.  and, besides, in what situation were the checkpatch warning
>> can be ignore=EF=BC=9F
>
> The only one that can be reasonably be ignored is the long line
> warning, and only if complying to the limit would make it less easy to
> understand.
>
>> >
>> > On Sun, Feb 25, 2018 at 09:53:08PM +0800, hao_zhang wrote:
>> >> +#define CAPTURE_IRQ_ENABLE_REG       0x0010
>> >> +#define CFIE(ch)     BIT(ch << 1 + 1)
>> >> +#define CRIE(ch)     BIT(ch << 1)
>> >
>> > You should also put your argument between parentheses here (and in all
>> > your other macros).
>>
>> Do you mean like this ?
>> #define CFIE(ch)     BIT((ch) << 1 + 1)
>> #define CRIE(ch)     BIT((ch) << 1)
>
> Yep, exactly. Otherwise, if you do something like CRIE(1 + 1), the
> result will be BIT(1 + 1 << 1), which will expand to 3, instead of 4.
>
> Also, CFIE looks a bit weird here, is it the offset that is
> incremented, or the value? You should probably have parentheses to
> make it explicit.

The vallue,
BIT(((ch) << 1) + 1) It seem not very nice...

uhmm...
In CAPTURE_IRQ_ENABLE_REG odd number is CFIE, even number is CRIE
each channel has one CFIE and CRIE.

we can also describe like this:
#define CFIE(ch)     BIT((ch) * 2 + 1)
#define CRIE(ch)     BIT((ch) * 2)

>
>> >
>> >> +static const u16 div_m_table[] =3D {
>> >> +     1,
>> >> +     2,
>> >> +     4,
>> >> +     8,
>> >> +     16,
>> >> +     32,
>> >> +     64,
>> >> +     128,
>> >> +     256
>> >> +};
>> >
>> > If this is just a power of two, you can use either the power of two /
>> > ilog2 to switch back and forth, instead of using that table.
>>
>> I think using table is more explicit and extended...
>
> If you didn't have a simple mapping between the register values and
> the divider value, then yeah, sure. But it's not the case here.
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
