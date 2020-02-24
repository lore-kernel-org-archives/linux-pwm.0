From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 1/7] dt-bindings: Add bindings for Azoteq
 IQS620A/621/622/624/625
Date: Mon, 24 Feb 2020 11:14:22 +0000
Message-ID: <20200224111422.GR3494@dell>
References: <1581895931-6056-1-git-send-email-jeff@labundy.com>
 <1581895931-6056-2-git-send-email-jeff@labundy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1581895931-6056-2-git-send-email-jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jeff LaBundy <jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Sun, 16 Feb 2020, Jeff LaBundy wrote:

> This patch adds device tree bindings for the Azoteq IQS620A, IQS621,
> IQS622, IQS624 and IQS625 multi-function sensors.
> 
> A total of three bindings are presented (one MFD and two child nodes);
> they are submitted as a single patch because the child node bindings
> have no meaning in the absence of the MFD binding.
> 
> Signed-off-by: Jeff LaBundy <jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
> Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
> Changes in v5:
>   - Corrected spelling of "data sheets" to "datasheets"
>   - Replaced words "additional air button" with "proximity-activated function"
>     in comment above first example
> 
> Changes in v4:
>   - None
> 
> Changes in v3:
>   - Specified 'additionalProperties: false' within the parent MFD node and all
>     child nodes ("keys", "hall-switch-north/south" and "pwm")
>   - Defined the "hall-switch-north/south" child nodes unconditionally and then
>     inverted the subsequent if/then to filter them from devices for which that
>     functionality is unavailable
>   - Added Reviewed-by trailer
> 
> Changes in v2:
>   - Removed "prox" child node and moved "keys" and "pwm" child nodes to their
>     own bindings
>   - Replaced linux,fw-file property with more common firmware-name property
>   - Converted all bindings to YAML
> 
>  .../devicetree/bindings/input/iqs62x-keys.yaml     | 132 +++++++++++++++
>  Documentation/devicetree/bindings/mfd/iqs62x.yaml  | 179 +++++++++++++++++++++
>  .../devicetree/bindings/pwm/iqs620a-pwm.yaml       |  32 ++++
>  3 files changed, 343 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/iqs62x-keys.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/iqs62x.yaml
>  create mode 100644 Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
