From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: convert google,cros-ec-pwm.txt to yaml
 format
Date: Wed, 5 Feb 2020 17:03:25 +0000
Message-ID: <20200205170325.GA19200@bogus>
References: <20200127103441.4618-1-dafna.hirschfeld@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200127103441.4618-1-dafna.hirschfeld@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-pwm@vger.kernel.org, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com, bleung@chromium.org, enric.balletbo@collabora.com, groeck@chromium.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dafna.hirschfeld@collabora.com, helen.koike@collabora.com, ezequiel@collabora.com, kernel@collabora.com, dafna3@gmail.com
List-Id: linux-pwm@vger.kernel.org

On Mon, 27 Jan 2020 11:34:41 +0100, Dafna Hirschfeld wrote:
> Convert the binding file google,cros-ec-pwm.txt to yaml format.
> 
> This was tested and verified on ARM64 with:
> 
> make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> 
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> ---
>  .../bindings/pwm/google,cros-ec-pwm.txt       | 23 -----------
>  .../bindings/pwm/google,cros-ec-pwm.yaml      | 40 +++++++++++++++++++
>  2 files changed, 40 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
