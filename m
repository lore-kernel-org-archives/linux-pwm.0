From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] dt-bindings: pwm: Convert imx tpm pwm to json-schema
Date: Wed, 27 May 2020 20:47:50 -0600
Message-ID: <20200528024750.GA3269380@bogus>
References: <1589439259-28510-1-git-send-email-Anson.Huang@nxp.com>
 <1589439259-28510-2-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1589439259-28510-2-git-send-email-Anson.Huang-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>
Cc: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Linux-imx-3arQi8VN3Tc@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Thu, 14 May 2020 14:54:19 +0800, Anson Huang wrote:
> Convert the imx tpm pwm binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>
> ---
>  .../devicetree/bindings/pwm/imx-tpm-pwm.txt        | 22 ---------
>  .../devicetree/bindings/pwm/imx-tpm-pwm.yaml       | 55 ++++++++++++++++++++++
>  2 files changed, 55 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.yaml
> 

Applied, thanks!
