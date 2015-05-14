From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] pwm: samsung: Use MODULE_DEVICE_TABLE() to include OF
 modalias
Date: Thu, 14 May 2015 09:37:51 +0900
Message-ID: <5553EE5F.7030105@samsung.com>
References: <1431563551-9461-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1431563551-9461-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Thierry Reding <thierry.reding@gmail.com>
Cc: Olof Johansson <olof@lixom.net>, Doug Anderson <dianders@chromium.org>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On 14.05.2015 09:32, Javier Martinez Canillas wrote:
> If the pwm-samsung driver is built as a module, modalias information is
> not filled so the module is not autoloaded. Use the MODULE_DEVICE_TABLE()
> macro to export the OF device ID so the module contains that information.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

I think many other Maxim/S[25]M drivers for Samsung boards may also be
affected... Probably they should also be updated.

Best regards,
Krzysztof
