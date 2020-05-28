From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: pwm: Convert mxs pwm to json-schema
Date: Thu, 28 May 2020 09:17:59 -0600
Message-ID: <20200528151759.GA91686@bogus>
References: <1589456470-2658-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-il1-f195.google.com ([209.85.166.195]:39661 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403988AbgE1PSC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 28 May 2020 11:18:02 -0400
Content-Disposition: inline
In-Reply-To: <1589456470-2658-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Anson Huang <Anson.Huang@nxp.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, Linux-imx@nxp.com, u.kleine-koenig@pengutronix.de, festevam@gmail.com, devicetree@vger.kernel.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, robh+dt@kernel.org, linux-kernel@vger.kernel.org, shawnguo@kernel.org

On Thu, 14 May 2020 19:41:10 +0800, Anson Huang wrote:
> Convert the mxs pwm binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  Documentation/devicetree/bindings/pwm/mxs-pwm.txt  | 17 ---------
>  Documentation/devicetree/bindings/pwm/mxs-pwm.yaml | 43 ++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 17 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/mxs-pwm.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/mxs-pwm.yaml
> 

Applied, thanks!
