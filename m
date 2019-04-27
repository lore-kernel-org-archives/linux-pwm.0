From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 2/3] pwm: meson: Add clock source configuration for
 Meson G12A
Date: Sat, 27 Apr 2019 22:29:21 +0200
Message-ID: <CAFBinCB9WS650JpuyGyjjOE=LNbChOdhAyb+qJMYWGosyMUa=w@mail.gmail.com>
References: <20190423133646.5705-1-narmstrong@baylibre.com> <20190423133646.5705-3-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423133646.5705-3-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, baylibre-upstreaming@groups.io, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Apr 23, 2019 at 3:37 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> For the PWM controller in the Meson G12A SoC, the EE domain and AO domain
> have different clock sources. This patch tries to describe them in the
> DT compatible data. The two AO PWM controller has different clock source,
> but the first AO controller (A & B) can reuse the AXG parents name.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
