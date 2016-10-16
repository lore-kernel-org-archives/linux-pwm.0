From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: Re: [PATCH 2/5] pwm: sun4i: Add support for PWM
 controller on sun6i SoCs
Date: Sun, 16 Oct 2016 22:29:17 +0800
Message-ID: <4823581476628157@web22j.yandex.ru>
References: <20161012042059.40015-1-icenowy@aosc.xyz>
	 <20161012042059.40015-2-icenowy@aosc.xyz>
	 <CAGb2v65P7SQyEv+b0mU_FA=CQxy7qX9h7HE4NivqjZ-ZBh94ww@mail.gmail.com>
	 <1476259803.2317.2.camel@Nokia-N900> <20161014125743.ykgeiqr4tynq7cmg@lukather>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBBQE5R3AAKGQEW6PKCGQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20161014125743.ykgeiqr4tynq7cmg@lukather>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: "wens-jdAy2FN1RRM@public.gmane.org" <wens-jdAy2FN1RRM@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, "linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hi,

14.10.2016, 20:58, "Maxime Ripard" <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>:
> Hi,
>
> On Wed, Oct 12, 2016 at 04:10:03PM +0800, Icenowy Zheng wrote:
>> =C2=A0> On Wed, Oct 12, 2016 at 12:20 PM, Icenowy Zheng <icenowy-87fMjt6guo8@public.gmane.org=
z> wrote:
>> =C2=A0> > The PWM controller in A31 is different with other Allwinner So=
Cs, with
>> =C2=A0> > a control register per channel (in other SoCs the control regi=
ster is
>> =C2=A0> > shared), and each channel are allocated 16 bytes of address (b=
ut only 8
>> =C2=A0> > bytes are used.). The register map in one channel is just like=
 a
>> =C2=A0> > single-channel A10 PWM controller, however, A31 have a differe=
nt
>> =C2=A0> > prescaler table than other SoCs.
>> =C2=A0> >
>> =C2=A0> > In order to use the driver for all 4 channels, device nodes sh=
ould be
>> =C2=A0> > created per channel.
>> =C2=A0>
>> =C2=A0> I think Maxime wants you to support the different register offse=
ts
>> =C2=A0> in this driver, and have all 4 channels in the same device (node=
).
>>
>> =C2=A0I think that will make the code much more complex... And in
>> =C2=A0hardware there may also be 4 controllers... as the register is
>> =C2=A0aligned at 0x10.
>
> You also have to think about it the other way around. This is exposed
> everywhere as a single device. There may be some undocumented
> registers hidden somewhere in the memory space of that device. How
> would you deal with that without touching the device tree?

Is the reason only they're listed in the one chapter of user manual?

>
> Exposing this as a single device is the best solution both from the
> philosophical point of view, but also from a maintainance aspect.

If we really do so, I will go back to the original patch (pwm-sun6i)
and merge 4 channels.

No other PWM block of Allwinner devices uses 4 control registers, and it's
a significant difference to make it a dedicated driver.

However, I still think we should have 4 nodes, since the 4 channels can wor=
k
very dedicatedly, with different control register... This can be a reason t=
o see
them as 4 dedicated controllers.

(And as PWM uses only oscXX, we cannot judge it according to the clock tree=
,
and Occam's Razor will apply to think it's 4 A10-like PWM controller...)

If we just think it's because it's a whole part, why don't we combine ehci =
and ohci
to one driver? Just because we can reuse {e,o}hci-platform...

It's the same reason to see it as 4 controllers.

>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

Regards,
Icenowy

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
