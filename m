From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCHv2 2/2] pwm: imx: support polarity inversion
Date: Thu, 23 Jan 2014 10:04:56 +0100
Message-ID: <1390467898-9216-1-git-send-email-s.hauer@pengutronix.de>
References: <20140123083714.3c6e86ae@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140123083714.3c6e86ae@ipc1.ka-ro>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Rob Landley <rob@landley.net>, Kumar Gala <galak@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

I thinking more of the following. I haven't tested it, but it has a negative
diffstat, so it must be good ;)

Sascha

----------------------------------------------------------------
Sascha Hauer (2):
      PWM: let of_xlate handlers check args count
      PWM: handle additional flags in of_pwm_simple_xlate

 drivers/pwm/core.c            | 41 +++++++----------------------------------
 drivers/pwm/pwm-atmel-tcb.c   |  2 --
 drivers/pwm/pwm-renesas-tpu.c |  2 --
 drivers/pwm/pwm-samsung.c     |  3 ---
 drivers/pwm/pwm-tiecap.c      |  2 --
 drivers/pwm/pwm-tiehrpwm.c    |  2 --
 drivers/pwm/pwm-vt8500.c      |  2 --
 include/linux/pwm.h           |  3 ---
 8 files changed, 7 insertions(+), 50 deletions(-)
