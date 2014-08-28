From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v4 00/11] drm: add support for Atmel HLCDC Display
 Controller
Date: Thu, 28 Aug 2014 14:19:22 +0200
Message-ID: <1805054.en0m884lPo@avalon>
References: <1406034695-15534-1-git-send-email-boris.brezillon@free-electrons.com>
 <1997793.CWhjU3F32E@avalon> <20140827095235.20334e2d@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140827095235.20334e2d@bbrezillon>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Boris BREZILLON <boris.brezillon@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Pawel Moll <pawel.moll@arm.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Lee Jones <lee.jones@linaro.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Bo Shen <voice.shen@atmel.com>, Kumar Gala <galak@codeaurora.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Andrew Victor <linux@maxim.org.za>, devicetree@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Boris,

On Wednesday 27 August 2014 09:52:35 Boris BREZILLON wrote:
> On Tue, 26 Aug 2014 01:39:21 +0200 Laurent Pinchart wrote:
> > On Thursday 21 August 2014 19:26:33 Boris BREZILLON wrote:
> >> On Thu, 21 Aug 2014 19:08:53 +0200
> >> Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:
> >> =

> >> [...]
> >> =

> >>>>>> While this could be acceptable when all drivers are statically
> >>>>>> linked in the kernel, it might be problematic when you're using
> >>>>>> modules, meaning that you won't be able to display anything on your
> >>>>>> LCD panel until your HDMI bridge module has been loaded.
> >>>>> =

> >>>>> No. HDMI should be using proper hotplugging anyway, hence it should
> >>>>> be always be loaded anyway. You're in for a world of pain if you
> >>>>> think you can run DRM with a driver that's composed of separate
> >>>>> kernel modules.
> >>>> =

> >>>> I was talking about the external RGB to HDMI encoder, should the
> >>>> driver for this encoder (which is not on On Chip block) be compiled
> >>>> statically too ?
> >>> =

> >>> Given the move to multiplatform kernels we need to aim for as few
> >>> modules compiled in as possible. I'd say this includes HDMI encoders,
> >>> panels and display controllers.
> >>> =

> >>>>> Also if you don't want to use deferred probe, then you're in for the
> >>>>> full hotplugging panel dance and that implies that you need to fix a
> >>>>> bunch of things in DRM (one being the framebuffer console
> >>>>> instantiation that I referred to in the other thread).
> >>>> =

> >>>> For now, I wait until there is a device connected on the RGB
> >>>> connector (connector status set to connector_status_connected) before
> >>>> creating an fbdev. It might not be the cleanest way to solve this
> >>>> issue, but it works :-).
> >>> =

> >>> Do you create a new drm_encoder at runtime for the HDMI encoder when
> >>> it appears ? I thought the DRM core and API were not able to correctly
> >>> cope with that.
> >> =

> >> I haven't started to work on the HDMI encoder yet, and ATM I only have
> >> a single connector (which is true from an HW POV), which is then bound
> >> to an LCD panel (the only type of remote endpoint I currently support).
> >> =

> >> BTW, I wonder how my use case should be represented in the DRM
> >> subsystem. As I said, from an HW POV I only have one RGB (or whatever
> >> name you choose for it) connector. But on such kind of connectors you
> >> can connect several output devices (panels, encoders, ...).
> >> And in my case I have 2 devices on the same RGB connector: a panel and
> >> an RGB to HDMI converter.
> > =

> > The DRM connector object was initially meant to model a physical user-
> > accessible connector on a board (VGA, DVI, HDMI, ...) and the properties
> > of the monitor plugged into it. It has then been (ab)used to represent
> > panels, as they're similar to monitors.
> > =

> > In your case the VGA and HDMI connectors should be modeled as DRM
> > connectors, the RGB to HDMI encoder as a DRM encoder, and the LCDC as a
> > DRM CRTC.
>
> I don't have any VGA connector (or I'm missing something :-)),

My bad.

> but I have an LCD panel and an RGB to HDMI encoder connected on the same =
RGB
> connector.

There's no such thing as an RGB connector in DRM. Your SoC has a parallel R=
GB =

video output (I assume it's a DPI bus). From a DRM point of view, that bus =

corresponds to the output of the CRTC.

> > As DRM hardcodes the pipeline model to CRTC -> encoder -> connector, you
> > will also need a DRM encoder in the VGA path. I suppose your board has a
> > VGA DAC, that's the component you should expose as a DRM encoder (even =
if
> > it can't be controlled and doesn't limit the valid modes).
> =

> Actually, my problem is that both devices are connected on the same RGB
> connector, and thus share the same display mode (resolution, HSYNC,
> VSYNC, RGB output mode, ...).
> This means that all remote devices have to agree on a specific mode if
> we want to mirror the display on several output devices, otherwise we
> must disable one of the output devices.

That's not really a problem. From a DRM perspective you need to model your =

device as

,------.       ,---------------.       ,-----------------.
| CRTC | -+--> | Dummy Encoder | ----> | Panel Connector |
`------=B4  |    `---------------=B4       `-----------------=B4
          |    ,---------------.       ,-----------------.
          \--> | HDMI Encoder  | ----> | HDMI Connector  |
               `---------------=B4       `-----------------=B4

The HDMI pipeline is pretty straightforward.

You have told me that the panel has a parallel RGB input without any encode=
r =

in the panel pipeline (by the way, which panel model are you using ?). =

However, DRM requires an encoder in every pipeline. You will thus need to =

instantiate a dummy encoder. One option would be to set the encoder and =

connector types to DRM_MODE_ENCODER_LVDS and DRM_MODE_CONNECTOR_LVDS =

respectively, as that's what userspace usually expects for panels. That =

doesn't reflect the reality in your case though, so creating a new =

DRM_MODE_CONNECTOR_DPI type might be needed, possibly to be used with =

DRM_MODE_ENCODER_NONE.

As neither encoder can modify the mode, the same mode will be output on the =

two connectors.

> >>>>> You also can't be using the current device tree bindings because
> >>>>> they all assume a dependency from the display controller/output to
> >>>>> the panel. For hotplugging you'd need the dependency the other way
> >>>>> around (the panel needs to refer to the output by phandle).
> >>>> =

> >>>> Here [1] is a proposal for notification support in the drm_panel
> >>>> infrastructure (which is not that complicated), and here [2] is how
> >>>> I use it in my atmel-hlcdc driver to generate hotplug events.
> >>> =

> >>> Is there a way we could use the component framework for that ? I know
> >>> that partial notification isn't supported at the moment, but Russell
> >>> agreed it was a real use case that should be implemented at some
> >>> point.
> >> =

> >> I'll give it a try.

-- =

Regards,

Laurent Pinchart
