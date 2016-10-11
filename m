From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/5] pwm: Add Allwinner A31 SoC support
Date: Tue, 11 Oct 2016 14:45:52 +0200
Message-ID: <20161011124552.GX3462@lukather>
References: <20161011063449.54775-1-icenowy@aosc.xyz>
 <20161011063449.54775-2-icenowy@aosc.xyz>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iXVVnr8Hn1WiTnFI"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBAV66O7QKGQE2LD65GA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20161011063449.54775-2-icenowy-ymACFijhrKM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--iXVVnr8Hn1WiTnFI
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Tue, Oct 11, 2016 at 02:34:46PM +0800, Icenowy Zheng wrote:
> This adds a generic PWM framework driver for the PWM controller found
> on Allwinner A31 and A31s SoCs.
> 
> The PWM controller is different with other Allwinner SoCs, with a
> control register per channel (in other SoCs the control register is
> shared), and each channel are allocated 16 bytes of address (but only 8
> bytes are used.)
> 
> In order to use the driver for all channels, device nodes should be
> created per channel.

I don't think there's any need for a new driver that duplicates most
of the logic. The bitfields look roughly the same, and the only
difference is the split difference.

This is something that can easily be handled without creating a new
driver using regmap's reg_field, or through an intermediate functino
that returns the register offset.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--iXVVnr8Hn1WiTnFI--
