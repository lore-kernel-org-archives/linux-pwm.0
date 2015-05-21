From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH] pwm: samsung: Use MODULE_DEVICE_TABLE() to include OF
 modalias
Date: Thu, 21 May 2015 10:13:50 +0200
Message-ID: <555D93BE.50406@collabora.co.uk>
References: <1431563551-9461-1-git-send-email-javier.martinez@collabora.co.uk> <5553EE5F.7030105@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <5553EE5F.7030105@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Olof Johansson <olof@lixom.net>, Doug Anderson <dianders@chromium.org>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hello Thierry,

On 05/14/2015 02:37 AM, Krzysztof Kozlowski wrote:
> On 14.05.2015 09:32, Javier Martinez Canillas wrote:
>> If the pwm-samsung driver is built as a module, modalias information is
>> not filled so the module is not autoloaded. Use the MODULE_DEVICE_TABLE()
>> macro to export the OF device ID so the module contains that information.
>> 
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> 
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> 

Any comments on this patch?

Best regards,
Javier
