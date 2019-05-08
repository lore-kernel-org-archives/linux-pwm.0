From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: meson-g12a: Add PWM nodes
Date: Wed, 08 May 2019 15:42:10 -0700
Message-ID: <7h7eb0in5p.fsf@baylibre.com>
References: <20190423133646.5705-1-narmstrong@baylibre.com> <20190423133646.5705-4-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423133646.5705-4-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com
Cc: baylibre-upstreaming@groups.io, Neil Armstrong <narmstrong@baylibre.com>, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Martin Blumenstingl <martin.blumenstingl@googlemail.com>
List-Id: linux-pwm@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This adds the EE and AO PWM nodes and the possible pinctrl settings.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>

Since bindings are acked, and there's no build dependency on the driver
itself, queuing this for v5.3 (branch: v5.3/dt64)

Thanks,

Kevin
