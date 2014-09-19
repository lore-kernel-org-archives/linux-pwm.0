From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH v5 05/11] drm: add Atmel HLCDC Display Controller support
Date: Fri, 19 Sep 2014 15:10:02 +0200
Message-ID: <CANq1E4TYv-ZCgZHbocVvqM54=hrYYSf3B-VY4FR8+WEp6EMMjg@mail.gmail.com>
References: <1410165822-16868-1-git-send-email-boris.brezillon@free-electrons.com>
 <1410165822-16868-6-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1410165822-16868-6-git-send-email-boris.brezillon@free-electrons.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, Pawel Moll <pawel.moll@arm.com>, devicetree@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Rob Herring <robh+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Bo Shen <voice.shen@atmel.com>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Andrew Victor <linux@maxim.org.za>
List-Id: linux-pwm@vger.kernel.org

Hi

On Mon, Sep 8, 2014 at 10:43 AM, Boris BREZILLON
<boris.brezillon@free-electrons.com> wrote:
[snip]
> +static int atmel_hlcdc_dc_drm_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +
> +       ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
> +       if (ret)
> +               return ret;
> +
> +       ret = drm_platform_init(&atmel_hlcdc_dc_driver, pdev);
> +       if (ret)
> +               return ret;

Please avoid any use of drm_platform_*(). Use drm_dev_alloc(),
drm_dev_register() directly. See my response on
  "[PATCH v3 1/5] drm/rockchip: Add basic drm driver":
for details. Also have a look at the tegra driver how to do it.

> +
> +       return 0;
> +}
> +
> +static int atmel_hlcdc_dc_drm_remove(struct platform_device *pdev)
> +{
> +       drm_put_dev(platform_get_drvdata(pdev));

Same here: please use dev_dev_*() directly:

drm_dev_unregister(ddev);
drm_dev_unref(ddev);


Thanks
David
