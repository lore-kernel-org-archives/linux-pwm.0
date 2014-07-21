From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
Date: Mon, 21 Jul 2014 20:32:40 +0200
Message-ID: <1910042.Kgt071QREf@avalon>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <1605488.5CKVSJec67@avalon> <20140721161810.282ca5e5@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140721161810.282ca5e5@bbrezillon>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, dri-devel@lists.freedesktop.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Bo Shen <voice.shen@atmel.com>, Lee Jones <lee.jones@linaro.org>, Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Samuel Ortiz <sameo@linux.intel.com>, Tim Niemeyer <tim.niemeyer@corscience.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-pwm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-pwm@vger.kernel.org

Hi Boris,

On Monday 21 July 2014 16:18:10 Boris BREZILLON wrote:
> On Mon, 21 Jul 2014 15:47:52 +0200 Laurent Pinchart wrote:
> > On Monday 21 July 2014 15:43:13 Boris BREZILLON wrote:
> >> On Mon, 21 Jul 2014 15:30:35 +0200 Thierry Reding wrote:
> >>> On Mon, Jul 21, 2014 at 03:22:05PM +0200, Laurent Pinchart wrote:
> >>>> On Monday 21 July 2014 14:55:23 Thierry Reding wrote:
> >>>>> On Mon, Jul 21, 2014 at 02:34:28PM +0200, Boris BREZILLON wrote:
> >>>>>> On Mon, 21 Jul 2014 14:16:42 +0200 Laurent Pinchart wrote:
> >>>>>>> On Monday 21 July 2014 14:12:47 Thierry Reding wrote:
> >>>>>>>> On Mon, Jul 21, 2014 at 11:57:37AM +0200, Boris BREZILLON wrote:
> >>>> [snip]
> >>>> 
> >>>>>>>>> The new drm_display_info structure should look like this [2]
> >>>>>>>>> (except that color_formats and bpc have not be removed yet), and
> >>>>>>>>> [1] is just here to show how the video_bus_format enum would
> >>>>>>>>> look like.
> >>>>>>>>> 
> >>>>>>>>> [1] http://code.bulix.org/rfd0yx-86557
> >>>>>>>>> [2] http://code.bulix.org/7n03b4-86556
> >>>>>>>> 
> >>>>>>>> Quoting from your paste:
> >>>>>>>> 	+   const enum video_bus_format *bus_formats;
> >>>>>>>> 	+   int nbus_formats;
> >>>>>>>> 
> >>>>>>>> Do we really need more than one?
> >>>>>>> 
> >>>>>>> We do if we want to replace the color_formats and bpc fields.
> >>>>>> 
> >>>>>> Yes, that's what I was about to answer :-).
> >>>>> 
> >>>>> Maybe we don't need to replace color_formats and bpc field
> >>>>> immediately. That could be done in a follow-up patch.
> >>>> 
> >>>> We don't need to replace them right now, but we should at least agree
> >>>> on how to replace them. Introducing a new field that would need to be
> >>>> replaced in the near future when removing color_formats and bpc would
> >>>> be a waste of time.
> >>> 
> >>> Sure. One of the problems I see with replacing color_formats and bpc
> >>> with the above is that some of the bits within color_formats are set
> >>> when the EDID is parsed. That implies that if they are replaced with
> >>> an array of formats, the array would need to be reallocated during
> >>> EDID parsing. That sounds like ugliness.
> >>> 
> >>> But if you can find a nice way to make it work that'd be great.
> >> 
> >> How about using a list instead of an array ?
> >> This way we can add elements to this list when parsing the EDID.
> >> 
> >> Or we can just define a maximum size for the bus_formats array when
> >> retrieving this info from EDID. If I'm correct we have at most 18 bus
> >> 
> >> formats:
> >>  - 3 color formats:
> >>    * RGB 4:4:4
> >>    * YCbCr 4:4:4
> >>    * YCbCr 4:4:2
> >>  
> >>  - 6 color depths: 6, 8, 10, 12, 14 and 16 bits per color
> > 
> > bpc isn't a bitmask, so EDID supports up to three formats only.
> 
> Yes, bpc only contains a single value for now, and it fits the
> DRM_EDID_DIGITAL_DEPTH field [1] (an enum defining the supported pixel
> depth).
> ITOH, DRM_EDID_HDMI_DC_XX [2] (which are referenced in the new
> drm_assign_hdmi_deep_color_info function) are just bitmasks and thus a
> display might support several color depth.
> 
> As a result, I wonder if we shouldn't start supporting several color depths
> (as we do for color formats)

If there's a use case for that, sure. It wouldn't be difficult, given that a 
bus format defines both the color format and the depths.

> [1]http://lxr.free-electrons.com/source/drivers/gpu/drm/drm_edid.c#L3436
> [2]https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/driv
> ers/gpu/drm/drm_edid.c?id=refs/tags/v3.16-rc6#n3440

-- 
Regards,

Laurent Pinchart
