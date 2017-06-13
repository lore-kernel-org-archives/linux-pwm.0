From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: pwm: meson: add comptabible for gxbb
 ao pwms
Date: Tue, 13 Jun 2017 17:18:59 -0500
Message-ID: <20170613221859.5e6wldvyybcav2y4@rob-hp-laptop>
References: <20170608122416.1993-1-jbrunet@baylibre.com>
 <20170608122416.1993-2-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34016 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751802AbdFMWTB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Jun 2017 18:19:01 -0400
Content-Disposition: inline
In-Reply-To: <20170608122416.1993-2-jbrunet@baylibre.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, Carlo Caione <carlo@caione.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org

On Thu, Jun 08, 2017 at 02:24:14PM +0200, Jerome Brunet wrote:
> Add compatible string to properly handle the PWMs found in the AO domain
> of the gxbb (and gxl) family
> 
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-meson.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
