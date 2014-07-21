From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
	atmel-hlcdc-dc driver
Date: Mon, 21 Jul 2014 18:06:30 +0100
Message-ID: <20140721170630.GG21766@n2100.arm.linux.org.uk>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com> <20140721143428.078b68a4@bbrezillon> <20140721125522.GE15238@ulmo> <2695740.osZpCPIB8S@avalon> <20140721133034.GI15238@ulmo> <20140721154313.1de8bf6f@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140721154313.1de8bf6f@bbrezillon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jean-Jacques Hiblot <jjhiblot-dLKeG7h1OhBDOHtkgc7UlQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Tim Niemeyer <tim.niemeyer-pDveNdigDaDu9UdzE1sIFA@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Victor <linux-PelNFVqkFnVyf+4FbqDuWQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni@free-el>
List-Id: linux-pwm@vger.kernel.org

On Mon, Jul 21, 2014 at 03:43:13PM +0200, Boris BREZILLON wrote:
> How about using a list instead of an array ?
> This way we can add elements to this list when parsing the EDID.
> 
> Or we can just define a maximum size for the bus_formats array when
> retrieving this info from EDID. If I'm correct we have at most 18 bus
> formats:
>  - 3 color formats:
>    * RGB 4:4:4
>    * YCbCr 4:4:4
>    * YCbCr 4:4:2
>  - 6 color depths: 6, 8, 10, 12, 14 and 16 bits per color

This starts to worry me.  What are we trying to do here - are we trying
to encode the connection between the CRTC and the encoder, the encoder
and the connector, or the connector and the device?

The encoder to connector and connector to device is mostly a function of
the interface spec itself (for example, many HDMI encoders take either a
RGB or YUV input and can convert it to the HDMI specified colourspaces for
transmission over the connector.)

If you want to do encoder to connector, what about VGA or some other
analogue signalling such as TV composite?  It's easy to take this too
far...

Surely the only one which matters is the CRTC to the encoder - that's
certainly true of all the setups I've come across so far.  As for that
interface, CRTCs I've seen can produce a /wide/ range of different
representations.

Some CRTCs (eg, AMBA CLCD) produce R, G, B signals scrunched down on to
the LSB bits of a LCD data bus (so RGB888 uses 24 bits, RGB444 would
use the LSB 12 bits of those 24 - rather than outputting the R4 bits on
a subset of the R8 bits.)

What about RGB565 - where you have differing number of bits for the
green channel from red/blue?

Then you have red/blue colour swapping at the CRTC (and similar for YUV)
such as on Dove / Armada.

Then there are some encoders have the ability to almost arbitarily map
their input pins according to whatever you choose (eg, TDA998x).

This problem isn't as quite as simple as "this is what EDID gives us"
and "these are the number of bits representing a colour".

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
