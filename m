From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 3/3] arm64: dts: meson-g12a: Add PWM nodes
Date: Sat, 13 Apr 2019 13:37:19 +0200
Message-ID: <CAFBinCDRFCo6GiTQ+zArqeuZCYK6BdfMVtRDUAhjG+oLEZyA8w@mail.gmail.com>
References: <20190412092337.6941-1-narmstrong@baylibre.com> <20190412092337.6941-4-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190412092337.6941-4-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, baylibre-upstreaming@groups.io, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Fri, Apr 12, 2019 at 11:24 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This adds the EE and AO PWM nodes and the possible pinctrl settings.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
I reviewed the controller definitions and picked three pinctrl nodes -
all of them are fine:
Reviewed-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>

that said, I had two questions regarding the AO PWM controllers in
PATCH 2/3 of this series which should be considered before applying
this patch
