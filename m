From: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 0/5] drivers: pwm: sun4i: Improve support for
 A64 and H6 SoCs
Date: Wed,  7 Mar 2018 02:07:14 +0000
Message-ID: <20180307020719.6675-1-andre.przywara@arm.com>
Reply-To: andre.przywara-5wv7dgnIgG8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDNZNK75ZIKRBD4U7XKAKGQEEAGTCAA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

This series adds PWM support for new Allwinner SoCs. Actually the A64 PWM 
is fully compatible with the A13 and H3 PWM IP, so the driver does not
need any additional code. But I use this opportunity to provide some
cleanup and to add optional reset controller support, which will be needed
for the H6.
Patch 1 removes a no longer used parameter from our per-SoC data structure,
to simplify patch 2, which groups SoCs with a compatible PWM controller.
Patch 3 adds optional reset controller support, the line will be deasserted
and asserted at the same time we enable and disable the clock. Patch 4 adds
the new compatible strings to the binding documentation (and just there,
we expect to use "allwinner,sun5i-a13-pwm" as a fallback compatible string).
The final patch 5 adds the respective PWM nodes to the A64 .dtsi.
This eventually does not enable the PWM on any new board at the moment, as
the PWM pins are either not usable (muxed with Ethernet) or exposed on
a header pin not dedicated to PWM. But the Pinebook (and Teres I) should be
able to use the PWM for the LCD backlights, plus users can enable the
R_PWM on their Pine64 boards, if they like.

Tested by manually enabling r_pwm on a Pine64-LTS.

Let me know how you like it and what needs to change.

Cheers,
Andre.

Andre Przywara (5):
  pwm: sun4i: drop unused .has_rdy member
  pwm: sun4i: simplify controller mapping
  pwm: sun4i: Introduce (optional) reset support
  dt-bindings: pwm: sunxi: add new compatible strings
  dts: sunxi: A64: Add PWM controllers

 .../devicetree/bindings/pwm/pwm-sun4i.txt          |  6 ++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 28 +++++++++
 drivers/pwm/pwm-sun4i.c                            | 66 ++++++++++++----------
 3 files changed, 69 insertions(+), 31 deletions(-)

-- 
2.14.1
