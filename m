From: Rob Herring <robh@kernel.org>
Subject: Re: [RESEND PATCH v5 5/9] pwm: add PWM modes
Date: Tue, 28 Aug 2018 17:27:08 -0500
Message-ID: <20180828222708.GA22527@bogus>
References: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
 <1535461286-12308-6-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1535461286-12308-6-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: thierry.reding@gmail.com, shc_work@mail.ru, mark.rutland@arm.com, corbet@lwn.net, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Aug 28, 2018 at 04:01:22PM +0300, Claudiu Beznea wrote:
> Add PWM normal and complementary modes.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm.txt |  9 +++++++--

Acked-by: Rob Herring <robh@kernel.org>

>  Documentation/pwm.txt                         | 26 +++++++++++++++++++++++---
>  include/dt-bindings/pwm/pwm.h                 |  1 +
>  3 files changed, 31 insertions(+), 5 deletions(-)
