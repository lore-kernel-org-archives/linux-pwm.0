From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/5] pwm: sun4i: Add support for PWM
 controller on sun6i SoCs
Date: Fri, 14 Oct 2016 14:57:43 +0200
Message-ID: <20161014125743.ykgeiqr4tynq7cmg@lukather>
References: <20161012042059.40015-1-icenowy@aosc.xyz>
 <20161012042059.40015-2-icenowy@aosc.xyz>
 <CAGb2v65P7SQyEv+b0mU_FA=CQxy7qX9h7HE4NivqjZ-ZBh94ww@mail.gmail.com>
 <1476259803.2317.2.camel@Nokia-N900>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ywwdiqnquul56udz"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBW5MQPAAKGQEQ5YEIWA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1476259803.2317.2.camel@Nokia-N900>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Cc: wens-jdAy2FN1RRM@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org


--ywwdiqnquul56udz
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Wed, Oct 12, 2016 at 04:10:03PM +0800, Icenowy Zheng wrote:
> > On Wed, Oct 12, 2016 at 12:20 PM, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org> wrote:
> > > The PWM controller in A31 is different with other Allwinner SoCs, with
> > > a control register per channel (in other SoCs the control register is
> > > shared), and each channel are allocated 16 bytes of address (but only 8
> > > bytes are used.). The register map in one channel is just like a
> > > single-channel A10 PWM controller, however, A31 have a different
> > > prescaler table than other SoCs.
> > > 
> > > In order to use the driver for all 4 channels, device nodes should be
> > > created per channel.
> > 
> > I think Maxime wants you to support the different register offsets
> > in this driver, and have all 4 channels in the same device (node).
> 
> I think that will make the code much more complex...  And in
> hardware there may also be 4 controllers... as the register is
> aligned at 0x10.

You also have to think about it the other way around. This is exposed
everywhere as a single device. There may be some undocumented
registers hidden somewhere in the memory space of that device. How
would you deal with that without touching the device tree?

Exposing this as a single device is the best solution both from the
philosophical point of view, but also from a maintainance aspect.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--ywwdiqnquul56udz--
