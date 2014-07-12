From: Rob Clark <robdclark@gmail.com>
Subject: Re: [RESEND PATCH v3 05/11] drm: add Atmel HLCDC Display Controller
 support
Date: Sat, 12 Jul 2014 14:37:16 -0400
Message-ID: <CAF6AEGv=irY0B-Cg6No7voadnShYQTwSLpZjk19xxX5qGcZeMw@mail.gmail.com>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <1404751384-5077-6-git-send-email-boris.brezillon@free-electrons.com>
 <20140712201654.565472d8@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140712201654.565472d8@bbrezillon>
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
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Samuel Ortiz <sameo@linux.intel.com>, Pawel Moll <pawel.moll@arm.com>, linux-pwm@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Nicolas Ferre <nicolas.ferre@atmel.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Tim Niemeyer <tim.niemeyer@corscience.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Rob Herring <robh+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Bo Shen <voice.shen@atmel.com>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Andrew Victor <linux@maxim.org.za>"linux-arm-kernel@lists.infradead.org" <li>
List-Id: linux-pwm@vger.kernel.org

On Sat, Jul 12, 2014 at 2:16 PM, Boris BREZILLON
<boris.brezillon@free-electrons.com> wrote:
> Hello,
>
> On Mon,  7 Jul 2014 18:42:58 +0200
> Boris BREZILLON <boris.brezillon@free-electrons.com> wrote:
>
>
>> +int atmel_hlcdc_layer_disable(struct atmel_hlcdc_layer *layer)
>> +{
>> +     struct atmel_hlcdc_layer_dma_channel *dma = &layer->dma;
>> +     unsigned long flags;
>> +     int i;
>> +
>> +     spin_lock_irqsave(&dma->lock, flags);
>> +     for (i = 0; i < layer->max_planes; i++) {
>> +             if (!dma->cur[i])
>> +                     break;
>> +
>> +             dma->cur[i]->ctrl = 0;
>> +     }
>> +     spin_unlock_irqrestore(&dma->lock, flags);
>> +
>> +     return 0;
>> +}
>
>
> I'm trying to simplify the hlcdc_layer code and in order to do that I
> need to know what's expected when a user calls plane_disable (or more
> exactly DRM_IOCTL_MODE_SETPLANE ioctl call with the frame buffer ID set
> to 0).
>
> The HLCDC Display Controller support two types of disable:
>
> 1) The plane is disabled at the end of the current frame (the is the
> solution I'm using)
>
> 2) The plane is disabled right away (I haven't tested it, but I think
> this solution could generate some sort of artifacts for a short period
> of time, because the framebuffer might be partially displayed)
>
> If solution 1 is chosen, should I wait for the plane to be actually
> disabled before returning ?

for cursor in particular, if you block, it is going to be a massive
slowdown for some apps.  I remember at least older gdm would rapidly
flash a spinning cursor.  As a result, if you wait for vsync each
time, it would take a couple minutes to login!

if #2 works, I'd recommend it.  Otherwise you may have to do some of
the same hijinks that I have to do in mdp4_crtc for the cursor.

BR,
-R

> A the moment, I'm not: I'm just asking for the plane to be disabled and
> then return. And this is where some of my complicated code come from,
> because I must handle the case where a user disable the plane then re
> enable it right away (modetest cursor test is doing a lot of cursor
> enable/disable in a short period of time, and this is how I tested all
> this weird use cases).
>
> Best Regards,
>
> Boris
>
> --
> Boris Brezillon, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
