From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 03/27] dt-bindings: Add doc for the Ingenic TCU drivers
Date: Fri, 28 Dec 2018 15:48:53 -0600
Message-ID: <20181228214853.GA8568@bogus>
References: <20181227181319.31095-1-paul@crapouillou.net>
 <20181227181319.31095-4-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181227181319.31095-4-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pwm@vger.kernel.org

On Thu, 27 Dec 2018 19:12:55 +0100, Paul Cercueil wrote:
> Add documentation about how to properly use the Ingenic TCU
> (Timer/Counter Unit) drivers from devicetree.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>      v4: New patch in this series. Corresponds to V2 patches 3-4-5 with
>          added content.
>     
>      v5: - Edited PWM/watchdog DT bindings documentation to point to the new
>            document.
>          - Moved main document to
>            Documentation/devicetree/bindings/timer/ingenic,tcu.txt
>          - Updated documentation to reflect the new devicetree bindings.
>     
>      v6: - Removed PWM/watchdog documentation files as asked by upstream
>          - Removed doc about properties that should be implicit
>          - Removed doc about ingenic,timer-channel /
>            ingenic,clocksource-channel as they are gone
>          - Fix WDT clock name in the binding doc
>          - Fix lengths of register areas in watchdog/pwm nodes
>     
>      v7: No change
> 
>      v8: - Fix address of the PWM node
>          - Added doc about system timer and clocksource children nodes
> 
>      v9: - Remove doc about system timer and clocksource children
>            nodes...
> 	 - Add doc about ingenic,pwm-channels-mask property
> 
>  .../devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt |  25 ----
>  .../devicetree/bindings/timer/ingenic,tcu.txt      | 139 +++++++++++++++++++++
>  .../bindings/watchdog/ingenic,jz4740-wdt.txt       |  17 ---
>  3 files changed, 139 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/ingenic,tcu.txt
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
