From: Boris BREZILLON <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v4 00/11] drm: add support for Atmel HLCDC Display
 Controller
Date: Thu, 21 Aug 2014 10:37:06 +0200
Message-ID: <20140821103706.2349915d@bbrezillon>
References: <1406034695-15534-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140821081619.GZ2452@ldesroches-Latitude-E6320>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140821081619.GZ2452@ldesroches-Latitude-E6320>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Ludovic Desroches <ludovic.desroches@atmel.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Pawel Moll <pawel.moll@arm.com>, devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Bo Shen <voice.shen@atmel.com>, Kumar Gala <galak@codeaurora.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hi Ludovic,

On Thu, 21 Aug 2014 10:16:19 +0200
Ludovic Desroches <ludovic.desroches@atmel.com> wrote:

> Hi Boris,
> 
> You can add
> 
> Tested-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Thanks for testing this driver.

> 
> Only one issue but not related to your patches, you can't display
> quickly the bootup logo since the panel detection takes too much
> time.

Yes, actually this is related to the device probe order: the
hlcdc-display-controller device is probed before the simple-panel, thus
nothing is detected on the RGB connector (I use of_drm_find_panel to
check for panel availability) when the display controller is
instantiated. I rely on the default polling infrastructure provided by
the DRM/KMS framework which polls for a new connector every 10s, and
this is far more than you kernel boot time.

Do anyone see a solution to reduce this delay (without changing the
polling interval). I thought we could add a notifier infrastructure to
the DRM panel framework, but I'm not sure this is how you want things
done...

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
