From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/4] doc: dt: pwm: add binding for ChromeOS EC PWM
Date: Mon, 6 Jun 2016 08:36:31 -0500
Message-ID: <20160606133631.GA20034@rob-hp-laptop>
References: <1464916904-37554-1-git-send-email-briannorris@chromium.org>
 <1464916904-37554-4-git-send-email-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464916904-37554-4-git-send-email-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Stephen Barber <smbarber@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Randall Spangler <rspangler@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
List-Id: linux-pwm@vger.kernel.org

On Thu, Jun 02, 2016 at 06:21:43PM -0700, Brian Norris wrote:
> The ChromeOS Embedded Controller can support controlling its attached
> PWMs via its host-command interface. The number of supported PWMs varies
> on a per-board basis, but we can autodetect this by checking the error
> codes, so we don't need an extra property for this. And because the EC
> only allows specifying the duty cycle and not the period, we don't
> specify the period via pwm-cells, and instead have only support 1 cell
> -- to specify the index.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> v2: dropped the "google,max-pwms" property
> 
>  .../devicetree/bindings/pwm/google,cros-ec-pwm.txt | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt

Acked-by: Rob Herring <robh@kernel.org>
