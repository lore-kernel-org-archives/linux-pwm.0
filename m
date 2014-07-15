From: Boris BREZILLON <boris.brezillon@free-electrons.com>
Subject: Re: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
Date: Tue, 15 Jul 2014 13:45:25 +0200
Message-ID: <20140715134525.43d209f2@bbrezillon>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <1584022.nQ4HpIUW7J@avalon> <20140710145626.48cb956f@bbrezillon>
 <33456066.4Q4p6nxKdU@avalon> <20140711140025.62873695@bbrezillon>
 <20140714101807.GC9870@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140714101807.GC9870@ulmo>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, dri-devel@lists.freedesktop.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Bo Shen <voice.shen@atmel.com>, Lee Jones <lee.jones@linaro.org>, Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Samuel Ortiz <sameo@linux.intel.com>, Tim Niemeyer <tim.niemeyer@corscience.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-pwm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-pwm@vger.kernel.org

On Mon, 14 Jul 2014 12:18:08 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Fri, Jul 11, 2014 at 02:00:25PM +0200, Boris BREZILLON wrote:
> > On Fri, 11 Jul 2014 12:37:46 +0200 Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:
> > > On Thursday 10 July 2014 14:56:26 Boris BREZILLON wrote:
> [...]
> > > > BTW, is there any reason for not defining an RGB connector type (I'm
> > > > currently defining HLCDC connector as an LVDS connector) ?
> > > 
> > > Not that I know of. The DRM API has been developed before display on embedded 
> > > systems became such a hot topic. If we had to redo it today, panels might be 
> > > exposed to userspace as such, with a connector. We have to live with the past, 
> > > so the connector will stay, but adding a new RGB connector type could make 
> > > sense (although we might need a different name, in a way the VGA and LVDS 
> > > connectors also carry RGB signals).
> > 
> > I had the same concern: I didn't find how this kind of connectors
> > was named (most of the time they're just referenced as RGB) :-).
> > What about RAW_RGB ?
> 
> Are there even panels that take raw RGB as input? In all cases I've seen
> (which admittedly may not be all that many) there's always a transparent
> RGB/LVDS bridge, so the "connector" is in fact LVDS, not RGB, even if
> the display controller outputs RGB directly.

At least the LCD module I'm using (FL500WVR00-A0T) is taking raw RGB as
input ;-).

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
