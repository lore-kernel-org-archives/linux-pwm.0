From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 2/3] pwm: meson: add compatible for the gxbb ao pwms
Date: Wed, 14 Jun 2017 10:38:05 -0700
Message-ID: <m21sqm4ghu.fsf@baylibre.com>
References: <20170608122416.1993-1-jbrunet@baylibre.com>
        <20170608122416.1993-3-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170608122416.1993-3-jbrunet@baylibre.com> (Jerome Brunet's
        message of "Thu, 8 Jun 2017 14:24:15 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Carlo Caione <carlo@caione.org>, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> On the gxbb (and gxl) family, the PWMs of the AO domain require a
> specific compatible because the possible input clocks are different
> from the EE PWMs input clocks.
>
> Since the number of possible input clocks is also different, the
> 'num_parents' field is added to all the meson pwm data.
>
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
