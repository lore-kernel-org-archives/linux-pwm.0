From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] pwm: meson: fix the G12A AO clock parents order
Date: Thu, 20 Jun 2019 14:38:43 -0700
Message-ID: <7hy31wdjj0.fsf@baylibre.com>
References: <20190620144655.2142-1-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190620144655.2142-1-narmstrong@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, martin.blumenstingl@googlemail.com, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The Amlogic G12A and G12B Documentation is wrong, the AO xtal and clk81
> clock source order is reversed, and validated when adding DVFS support by
> using the PWM AO D output to control the CPU supply voltage.
>
> The vendor tree also uses the reversed xtal and clk81 order at [1].
>
> [1] https://github.com/hardkernel/linux/blob/odroidn2-4.9.y/drivers/amlogic/pwm/pwm_meson.c#L462
>
> Fixes: f41efceb46e6 ("pwm: meson: Add clock source configuration for Meson G12A")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>
